import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 👈 مهم
import 'package:masrofy/viewmodels/transaction_viewModel.dart';
import '../../widgets/food_expenseitem.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid; // 👈 جلب uid الحالي

    if (uid == null) {
      return const Scaffold(body: Center(child: Text("User not logged in")));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<TransactionViewmodel>(
          builder: (context, value, child) {
            return StreamBuilder(
              stream: value.getExpensesByCategory("food"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Food Transactions Yet",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                final transactions = snapshot.data!;

                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tx = transactions[index];

                    // ✅ التعامل مع التاريخ كـ String أو Timestamp
                    // DateTime? date;
                    // if (data["date"] is String) {
                    //   try {
                    //     date = DateTime.parse(data["date"]);
                    //   } catch (e) {
                    //     date = null;
                    //   }
                    // } else if (data["date"] is Timestamp) {
                    //   date = (data["date"] as Timestamp).toDate();
                    // }

                    return FoodExpenseItem(
                      title: tx.title,
                      date: "${tx.date.day}-${tx.date.month}-${tx.date.year}",
                      amount:
                          "${tx.type == "income" ? "+" : "-"} \$${tx.amount.toStringAsFixed(2)}",
                      color: tx.type == "income" ? Colors.green : Colors.red,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
