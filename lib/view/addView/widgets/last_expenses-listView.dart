import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masrofy/widgets/add_expenseitem.dart';

class LastExpensesListView extends StatelessWidget {
  const LastExpensesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    if (uid == null) {
      return const Center(child: Text("User not logged in"));
    }

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("expenses")
            .where("userId", isEqualTo: uid) // 🔹 يجيب بس مصاريف اليوزر الحالي
            //.orderBy("date", descending: true)
            .limit(10)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No expenses found"));
          }

          final expenses = snapshot.data!.docs;

          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final data = expenses[index].data() as Map<String, dynamic>;

              final title = data["title"] ?? "";
              final amount = (data["amount"] as num?)?.toDouble() ?? 0.0;

              DateTime date;
              final rawDate = data["date"];
              if (rawDate is Timestamp) {
                date = rawDate.toDate();
              } else if (rawDate is String) {
                date = DateTime.tryParse(rawDate) ?? DateTime.now();
              } else {
                date = DateTime.now();
              }

              return AddExpenseItem(
                title: title,
                date: "${date.day}/${date.month}/${date.year}",
                amount: "-\$${amount.toStringAsFixed(2)}",
                color: Colors.red,
              );
            },
          );
        },
      ),
    );
  }
}
