import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 🟢 لازم نجيب الـ uid
import 'package:masrofy/models/transaction_model.dart';

class CustomExpandedIncome extends StatelessWidget {
  const CustomExpandedIncome({super.key});

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("incomes")
          .where("userId", isEqualTo: uid)
          //  .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No income found"));
        }

        final incomes = snapshot.data!.docs
            .map((doc) => TransactionModel.fromFirestore(doc))
            .toList();

        final sourceIcons = {
          "salary": Icons.work,
          "freelance": Icons.laptop_mac,
          "gift": Icons.card_giftcard,
          "investment": Icons.trending_up,
        };

        return ListView.builder(
          itemCount: incomes.length,
          itemBuilder: (context, index) {
            final income = incomes[index];
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
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${income.date.day}/${income.date.month}/${income.date.year}",
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
              trailing: Text(
                "+${income.amount.toStringAsFixed(2)} EGP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
