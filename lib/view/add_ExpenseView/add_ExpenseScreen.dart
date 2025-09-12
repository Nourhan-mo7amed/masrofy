import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/constants/month_name.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 👈 لازم نضيفها
import 'package:masrofy/models/ExpenseModel.dart';
import 'package:masrofy/models/category_model.dart';
import 'package:masrofy/models/transaction_model.dart';
import 'package:masrofy/viewmodels/transaction_viewModel.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? selectedDate;
  CategoryModel? selectedCategory;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<CategoryModel> get categories {
    final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
    return [
      CategoryModel(
        id: "food",
        name: "Food",
        icon: "🍔",
        color: Colors.purple,
        userId: currentUserId,
      ),
      CategoryModel(
        id: "shopping",
        name: "Shopping",
        icon: "🛍️",
        color: Colors.orange,
        userId: currentUserId,
      ),
      CategoryModel(
        id: "bills",
        name: "Bills",
        icon: "📄",
        color: Colors.red,
        userId: currentUserId,
      ),
      CategoryModel(
        id: "transport",
        name: "Transport",
        icon: "🚗",
        color: Colors.blue,
        userId: currentUserId,
      ),
    ];
  }

  Future<void> _saveExpense() async {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠️ Please fill all required fields")),
      );
      return;
    }
    if (selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("⚠️ Please select a category")));
      return;
    }
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("❌ User not logged in")));
      return;
    }
    final transaction = TransactionModel(
      id: FirebaseFirestore.instance.collection("transactions").doc().id,
      title: _titleController.text.trim(),
      amount: double.tryParse(_amountController.text.trim()) ?? 0.0,
      date: selectedDate!,
      userId: userId, // 👈 هنا أضفنا uid
      notes: _notesController.text.trim(),
      type: 'expense',
      source: null,
      categoryId: selectedCategory!.id,
    );
    try {
      final viewModel = Provider.of<TransactionViewmodel>(
        context,
        listen: false,
      );
      await viewModel.addTransaction(transaction);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("✅ Expense Added Successfully")));
      Navigator.pop(context);
    } catch (e) {
      print("❌ Error saving expense: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Failed to save expense")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Expense",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                const Text(
                  "Expense Title",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: l10n.food,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                /// Category
                const Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  children: categories.map((cat) {
                    final isSelected = selectedCategory?.id == cat.id;
                    return ChoiceChip(
                      label: Text(cat.icon),
                      selected: isSelected,
                      selectedColor: cat.color.withOpacity(0.2),
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = cat;
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amount",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.attach_money, size: 20),
                              hintText: "\$ 2000",
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
                            "Select Date",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),

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
                              prefixIcon: const Icon(
                                Icons.calendar_today,
                                size: 20,
                              ),
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

                /// Notes
                const Text(
                  "Notes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _notesController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 70),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _saveExpense,
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
