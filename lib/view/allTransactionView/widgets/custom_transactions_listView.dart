import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/models/ExpenseModel.dart';
import 'package:masrofy/models/transaction_model.dart';

class CustomTransactionsListview extends StatelessWidget {
  const CustomTransactionsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
              "transactions",
            ) // 🟢 لو مستخدم UID: users/{uid}/expenses
            .orderBy("date", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No transactions found"));
          }

          final transaction = snapshot.data!.docs.map((doc) {
            return TransactionModel.fromJson(doc.data(), doc.id);
          }).toList();

          return ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              final txn = transaction[index];

              // 🟢 Map categories IDs to Icons
              final categoryIcons = {
                "food": Icons.fastfood,
                "shopping": Icons.shopping_bag,
                "transport": Icons.directions_car,
                "rent": Icons.home,
              };

              // لو دخل عندك mapping sources
              final sourceIcons = {
                "salary": Icons.work,
                "freelance": Icons.laptop_mac,
                "gift": Icons.card_giftcard,
                "investment": Icons.trending_up,
              };
              final isExpense = txn.type == "expense";
              final amountColor = isExpense
                  ? Colors.red.shade700
                  : Colors.green.shade700;
              final amountPrefix = isExpense ? "-" : "+";

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: isExpense
                      ? Colors.red.shade100
                      : Colors.green.shade100,
                  child: Icon(
                    isExpense
                        ? categoryIcons[txn.categoryId] ?? Icons.category
                        : sourceIcons[txn.source] ?? Icons.attach_money,
                    color: isExpense ? Colors.red : Colors.green,
                  ),
                ),
                title: Text(
                  txn.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (txn.notes != null && txn.notes!.isNotEmpty)
                      Text(
                        txn.notes!,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    Text(
                      "${txn.date.day}/${txn.date.month}/${txn.date.year}",
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
                trailing: Text(
                  "$amountPrefix${txn.amount.toStringAsFixed(2)} EGP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: amountColor,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
