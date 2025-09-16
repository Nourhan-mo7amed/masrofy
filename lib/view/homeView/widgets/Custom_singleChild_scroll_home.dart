import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masrofy/view/homeView/widgets/custom_home_page_card.dart';
import 'package:masrofy/widgets/expenseItem.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../chatbotView/chatbotScreen.dart';

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
    final loc = AppLocalizations.of(context)!; // ✅ جبت الترجمة

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
                child: Center(
                  child: Text(
                    loc.home, // ✅ بدل Home
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.smart_toy_outlined,
                  size: 35,
                  
                ),
                onPressed: () {
                  if (ChatBotScreen.isCompleted) {
                    Navigator.pushNamed(
                      context,
                      '/report',
                      arguments: ChatBotScreen.answers,
                    );
                  } else {
                    Navigator.pushNamed(context, '/chatbot');
                  }
                },
              ),
              CustomHomePageCard(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Text(
                  loc.expense, // ✅ بدل Expense
                  style: const TextStyle(fontSize: 30),
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
                  title: loc.shopping, // ✅ بدل Shopping
                  amount: "- ${totals["shopping"]!.toStringAsFixed(2)}",
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/bills');
                },
                child: ExpenseItem(
                  icon: Icons.receipt_long_outlined,
                  color: Colors.pink,
                  title: loc.bills, // ✅ بدل bills
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
                  title: loc.food, // ✅ بدل Food
                  amount: "- ${totals["food"]!.toStringAsFixed(2)}",
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/transport');
                },
                child: ExpenseItem(
                  icon: Icons.directions_car_outlined,
                  color: Colors.blue,
                  title: loc.transport, // ✅ بدل Transport
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
