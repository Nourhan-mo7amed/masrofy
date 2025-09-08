import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/models/ExpenseModel.dart';

class CustomExpamdedExpenses extends StatelessWidget {
  const CustomExpamdedExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
  child: StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("expenses") // 🟢 لو مستخدم UID: users/{uid}/expenses
        .orderBy("date", descending: true)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(child: Text("No expenses found"));
      }

      final expenses = snapshot.data!.docs.map((doc) {
        return ExpenseModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];

          // 🟢 Map categories IDs to Icons
          final categoryIcons = {
            "food": Icons.fastfood,
            "shopping": Icons.shopping_bag,
            "transport": Icons.directions_car,
            "rent": Icons.home,
          };

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Icon(
                categoryIcons[expense.categoryId] ?? Icons.category,
                color: Colors.blue,
              ),
            ),
            title: Text(
              expense.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (expense.note != null && expense.note!.isNotEmpty)
                  Text(expense.note!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                Text(
                  "${expense.date.day}/${expense.date.month}/${expense.date.year}",
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
            trailing: Text(
              "-${expense.amount.toStringAsFixed(2)} EGP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
            ),
          );
        },
      );
    },
  ),
)
;
  }
}