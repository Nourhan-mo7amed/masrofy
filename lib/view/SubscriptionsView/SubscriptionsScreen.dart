import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/subscriptions_ExpenseItem.dart';

class Subscriptions extends StatelessWidget {
  const Subscriptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscriptions",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("expenses") // 👈 الكولكشن اللي بتخزن فيه
              .where("categoryId", isEqualTo: "bills")
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
                final data = docs[index].data() as Map<String, dynamic>;
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
                  // في حالة إنه Timestamp
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
