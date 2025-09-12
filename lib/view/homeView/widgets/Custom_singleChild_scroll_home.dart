import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masrofy/view/homeView/widgets/custom_home_page_card.dart';
import 'package:masrofy/widgets/expenseItem.dart';

class CustomSingleChildScrollViewHome extends StatelessWidget {
  const CustomSingleChildScrollViewHome({super.key, required this.context});

  final BuildContext context;
  Stream<Map<String, double>> _getCategoryTotals() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection("expenses")
        .where("userId", isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
          final Map<String, double> totals = {
            "food": 0.0,
            "shopping": 0.0,
            "bills": 0.0,
            "transport": 0.0,
          };

          for (var doc in snapshot.docs) {
            final data = doc.data();
            final categoryId = data["categoryId"] ?? "another";
            final amount = (data["amount"] as num?)?.toDouble() ?? 0.0;

            if (totals.containsKey(categoryId)) {
              totals[categoryId] = totals[categoryId]! + amount;
            }
          }

          return totals;
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, double>>(
      stream: _getCategoryTotals(),
      builder: (context, snapshot) {
        final totals =
            snapshot.data ??
            {"food": 0.0, "shopping": 0.0, "bills": 0.0, "transport": 0.0};

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.list, size: 30),
                    ),
                    const SizedBox(width: 90),
                    const Center(
                      child: Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomHomePageCard(),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  "Expense",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/shopping');
                },
                child: ExpenseItem(
                  icon: Icons.shopping_bag_outlined,
                  color: Colors.orange,
                  title: "Shopping",
                  amount: "- ${totals["shopping"]!.toStringAsFixed(2)}",
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/bills');
                },
                child: ExpenseItem(
                  icon: Icons.subscriptions_outlined,
                  color: Colors.pink,
                  title: "bills",
                  amount: "- ${totals["bills"]!.toStringAsFixed(2)}",
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/food');
                },
                child: ExpenseItem(
                  icon: Icons.fastfood_outlined,
                  color: Colors.purple,
                  title: "Food",
                  amount: "- ${totals["food"]!.toStringAsFixed(2)}",
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/transport');
                },
                child: ExpenseItem(
                  icon: Icons.widgets_outlined,
                  color: Colors.blue,
                  title: "Transport",
                  amount: "- ${totals["transport"]!.toStringAsFixed(2)}",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
