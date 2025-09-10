import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/food_expenseitem.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("expenses")
              .where("categoryId", isEqualTo: "food")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No Food Transactions Yet",
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

                // ✅ التعامل مع التاريخ كـ String
                final dateString = data["date"] as String?;
                DateTime? date;
                if (dateString != null) {
                  try {
                    date = DateTime.parse(dateString);
                  } catch (e) {
                    date = null;
                  }
                }

                return FoodExpenseItem(
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
