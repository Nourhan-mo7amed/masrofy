import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masrofy/models/transaction_model.dart';

class CustomExpandedExpenses extends StatelessWidget {
  const CustomExpandedExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("expenses")
          .where("userId", isEqualTo: uid)
        //  .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No expenses found"));
        }

        final expenses = snapshot.data!.docs
            .map((doc) => TransactionModel.fromFirestore(doc))
            .toList();

        final categoryIcons = {
          "food": Icons.fastfood,
          "shopping": Icons.shopping_bag,
          "transport": Icons.directions_car,
          "rent": Icons.home,
        };

        return ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            final expense = expenses[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red.shade100,
                child: Icon(
                  categoryIcons[expense.categoryId] ?? Icons.category,
                  color: Colors.red,
                ),
              ),
              title: Text(
                expense.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (expense.notes != null && expense.notes!.isNotEmpty)
                    Text(
                      expense.notes!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
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
    );
  }
}