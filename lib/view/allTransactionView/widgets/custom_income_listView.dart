import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 🟢 لازم نجيب الـ uid
import 'package:masrofy/models/IncomeModel.dart';
import 'package:masrofy/models/transaction_model.dart';

class CustomExpandedIncomes extends StatelessWidget {
  const CustomExpandedIncomes({super.key});

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid; // 🟢 جبت الـ uid

    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("incomes")
            .where("userId", isEqualTo: uid) // 🟢 فلترة باليوزر
            // .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No incomes found"));
          }

          final incomes = snapshot.data!.docs.map((doc) {
            return TransactionModel.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>,
            );
          }).toList();

          return ListView.builder(
            itemCount: incomes.length,
            itemBuilder: (context, index) {
              final income = incomes[index];

              final sourceIcons = {
                "salary": Icons.work,
                "freelance": Icons.laptop_mac,
                "gift": Icons.card_giftcard,
                "investment": Icons.trending_up,
              };

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Icon(
                    sourceIcons[income.source] ?? Icons.attach_money,
                    color: Colors.green,
                  ),
                ),
                title: Text(
                  income.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (income.notes != null && income.notes!.isNotEmpty)
                      Text(
                        income.notes!,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    Text(
                      "${income.date.day}/${income.date.month}/${income.date.year}",
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
                trailing: Text(
                  "${income.amount.toStringAsFixed(2)} EGP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
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
