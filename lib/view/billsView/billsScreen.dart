import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 🟢 عشان نجيب uid
import 'package:masrofy/l10n/app_localizations.dart';
import '../../widgets/subscriptions_ExpenseItem.dart';

class Billsscreen extends StatelessWidget {
  const Billsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("❌ User not logged in")),
      );
    }
    final String uid = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bills",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("expenses")
              .where("userId", isEqualTo: uid) // 🟢 فلترة باليوزر الحالي
              .where("categoryId", isEqualTo: "bills") // 🟢 فلترة بالكاتيجوري
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No Bills Transactions Yet",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data();
                final title = data["title"] ?? "No Title";
                final double amount =
                    (data["amount"] as num?)?.toDouble() ?? 0.0;
                final String type = data["type"] ?? "expense";

                // ✅ التاريخ String أو Timestamp
                DateTime? date;
                if (data["date"] is String) {
                  try {
                    date = DateTime.parse(data["date"]);
                  } catch (e) {
                    date = null;
                  }
                } else if (data["date"] != null) {
                  try {
                    date = (data["date"] as Timestamp).toDate();
                  } catch (e) {
                    date = null;
                  }
                }

                return SubscriptionsExpenseitem(
                  title: title,
                  date: date != null
                      ? "${date.day}-${date.month}-${date.year}"
                      : "Unknown",
                  amount:
                      "${type == "income" ? "+" : "-"} \$${amount.toStringAsFixed(2)}",
                  color: type == "income" ? Colors.green : Colors.red,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
