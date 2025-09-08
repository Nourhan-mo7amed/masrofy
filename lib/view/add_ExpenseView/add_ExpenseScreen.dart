import 'package:flutter/material.dart';
import 'package:masrofy/core/constants/month_name.dart';
import 'package:masrofy/models/ExpenseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // 🟢 Firestore

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreen createState() => _AddExpenseScreen();
}

class _AddExpenseScreen extends State<AddExpenseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? selectedDate;
  int selectedCategory = -1;

  final List<IconData> categories = [
    Icons.widgets_outlined,
    Icons.shopping_bag,
    Icons.receipt,
    Icons.fastfood_outlined,
  ];

  final List<String> categoryIds = [
    "general",
    "shopping",
    "bills",
    "food",
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _saveExpense() async {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        selectedDate == null ||
        selectedCategory == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠️ Please fill all fields")),
      );
      return;
    }

    final expense = ExpenseModel(
      id: _firestore.collection("expenses").doc().id, // 🟢 Auto ID
      title: _titleController.text.trim(),
      amount: double.tryParse(_amountController.text.trim()) ?? 0,
      categoryId: categoryIds[selectedCategory],
      date: selectedDate!,
      note: _notesController.text.trim(),
    );

    try {
      await _firestore
          .collection("expenses")
          .doc(expense.id)
          .set(expense.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Expense Added")),
      );

      Navigator.pop(context); // 🟢 رجوع بعد الحفظ
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Expense",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 العنوان
                Text("Expense Title",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Food",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // 🔹 الكاتيجوري
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15),
                    Row(
                      children: List.generate(categories.length, (index) {
                        final List<Color> colors = [
                          Colors.blue,
                          Colors.orange,
                          Colors.red,
                          Colors.purple,
                        ];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: selectedCategory == index
                                  ? colors[index].withOpacity(0.2)
                                  : Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              categories[index],
                              color: selectedCategory == index
                                  ? colors[index]
                                  : Colors.black54,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // 🔹 المبلغ + التاريخ
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Amount",
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select Date",
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
                              prefixIcon: Icon(Icons.calendar_today, size: 20),
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
                SizedBox(height: 20),

                // 🔹 الملاحظات
                Text("Notes", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
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

                // 🔹 زرار الحفظ
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _saveExpense, // 🟢 استدعاء الفانكشن
                    child: Text(
                      "Save",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
