import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ عشان نجيب uid
import 'package:masrofy/core/constants/month_name.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/models/transaction_model.dart';
import 'package:masrofy/viewmodels/transaction_viewModel.dart';
import 'package:provider/provider.dart';

class AddIncomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.addIncome, // ✅
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: const SingleChildScrollView(child: CustomIncomeFormField()),
        ),
      ),
    );
  }
}

class CustomIncomeFormField extends StatefulWidget {
  const CustomIncomeFormField({super.key});

  @override
  State<CustomIncomeFormField> createState() => _CustomIncomeFormFieldState();
}

class _CustomIncomeFormFieldState extends State<CustomIncomeFormField> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _saveIncome() async {
    final loc = AppLocalizations.of(context)!;

    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.fillRequiredFields)), // ✅
      );
      return;
    }
    final userId = FirebaseAuth.instance.currentUser?.uid; // ✅ جلب uid الحالي
    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(loc.userNotLoggedIn))); // ✅
      return;
    }
    final transaction = TransactionModel(
      id: " ",
      userId: userId, // ✅ ربط الدخل باليوزر الحالي
      title: _titleController.text.trim(),
      amount: double.tryParse(_amountController.text.trim()) ?? 0.0,
      date: selectedDate!,
      notes: _notesController.text.trim(),
      type: "income",
      categoryId: null,
      source: null,
    );
    try {
      final viewModel = Provider.of<TransactionViewmodel>(
        context,
        listen: false,
      );
      await viewModel.addTransaction(transaction);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(loc.incomeAddedSuccessfully))); // ✅
      Navigator.pop(context);

      // reset form
      _titleController.clear();
      _amountController.clear();
      _dateController.clear();
      _notesController.clear();
      setState(() => selectedDate = null);
    } catch (e) {
      print("❌ Error saving income: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(loc.failedToSaveIncome))); // ✅
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.incomeTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ), // ✅
          const SizedBox(height: 10),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: loc.salaryHint, // ✅
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.amount, // ✅
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.attach_money, size: 20),
                        hintText: loc.amountHint, // ✅
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.selectDate, // ✅
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                            _dateController.text =
                                "${pickedDate.day} ${monthName(pickedDate.month)} ${pickedDate.year}";
                          });
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_today, size: 20),
                        hintText: "22 July 2025",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            loc.notes,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ), // ✅
          const SizedBox(height: 10),
          TextField(
            controller: _notesController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: loc.notesHint, // ✅
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 80),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color(0xFF6C63FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _saveIncome,
              child: Text(
                loc.save, // ✅
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "january",
      "february",
      "march",
      "april",
      "may",
      "june",
      "july",
      "august",
      "september",
      "october",
      "november",
      "december",
    ];
    return months[month - 1];
  }
}
