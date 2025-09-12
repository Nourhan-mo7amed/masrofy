import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 👈 لازم نضيفها
import 'package:masrofy/models/ExpenseModel.dart';
import 'package:masrofy/core/constants/month_name.dart';
import 'package:masrofy/models/category_model.dart';

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
        selectedDate == null ||
        selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Please fill all fields")),
      );
      return;
    }

    /// 👇 ناخد uid من FirebaseAuth
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("❌ User not logged in")));
      return;
    }

    final expenseId = _firestore.collection("expenses").doc().id;

    final expense = ExpenseModel(
      id: expenseId,
      title: _titleController.text.trim(),
      amount: double.tryParse(_amountController.text.trim()) ?? 0,
      categoryId: selectedCategory!.id,
      date: selectedDate!,
      userId: userId, // 👈 هنا أضفنا uid
      note: _notesController.text.trim(),
    );

    try {
      await _firestore
          .collection("expenses")
          .doc(expense.id)
          .set(expense.toJson());

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("✅ Expense Added")));

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    hintText: "Food",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

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
                const SizedBox(height: 20),

                /// Amount + Date
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.attach_money, size: 20),
                          hintText: "\$ 2000",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextField(
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
                const SizedBox(height: 70),

                /// Save Button
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
                    child: const Text(
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
}
