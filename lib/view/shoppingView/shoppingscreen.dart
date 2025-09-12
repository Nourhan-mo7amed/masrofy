import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 👈 مهم
import '../../widgets/shopping_expenseitem.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid; // 👈 جلب uid الحالي

    if (uid == null) {
      return const Scaffold(
        body: Center(child: Text("User not logged in")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shopping",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("expenses")
              .where("categoryId", isEqualTo: "shopping")
              .where("userId", isEqualTo: uid) // 👈 فلترة بالـ uid
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No Shopping Transactions Yet",
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

                // ✅ التعامل مع التاريخ سواء String أو Timestamp
                DateTime? date;
                if (data["date"] is String) {
                  try {
                    date = DateTime.parse(data["date"]);
                  } catch (e) {
                    date = null;
                  }
                } else if (data["date"] is Timestamp) {
                  date = (data["date"] as Timestamp).toDate();
                }

                return ShoppingExpenseitem(
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
