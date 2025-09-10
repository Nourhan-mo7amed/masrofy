import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/shopping_expenseitem.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Shopping", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("expenses") // 👈 نفس الكولكشن اللي بتحفظ فيه
              .where("categoryId", isEqualTo: "shopping")
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
                final data = docs[index].data() as Map<String, dynamic>;
                final title = data["title"] ?? "No Title";
                final double amount =
                    (data["amount"] as num?)?.toDouble() ?? 0.0;
                final String type = data["type"] ?? "expense";

                // ✅ التعامل مع التاريخ كـ String (مش Timestamp)
                final dateString = data["date"] as String?;
                DateTime? date;
                if (dateString != null) {
                  try {
                    date = DateTime.parse(dateString);
                  } catch (e) {
                    date = null;
                  }
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
