import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomHomePageCard extends StatelessWidget {
  const CustomHomePageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    // نقرأ الـ income والـ expenses في نفس الوقت
    final incomeStream = FirebaseFirestore.instance
        .collection("incomes")
        .where("userId", isEqualTo: uid)
        .snapshots();

    final expensesStream = FirebaseFirestore.instance
        .collection("expenses")
        .where("userId", isEqualTo: uid)
        .snapshots();

    return Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 52, 92, 224),
            Color.fromARGB(255, 211, 74, 181),
            Color.fromARGB(255, 245, 183, 51),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: incomeStream,
        builder: (context, incomeSnapshot) {
          return StreamBuilder<QuerySnapshot>(
            stream: expensesStream,
            builder: (context, expensesSnapshot) {
              if (!incomeSnapshot.hasData || !expensesSnapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              double income = 0;
              double expenses = 0;

              // حساب الـ income
              for (var doc in incomeSnapshot.data!.docs) {
                final data = doc.data() as Map<String, dynamic>;
                income += (data["amount"] as num?)?.toDouble() ?? 0.0;
              }

              // حساب الـ expenses
              for (var doc in expensesSnapshot.data!.docs) {
                final data = doc.data() as Map<String, dynamic>;
                expenses += (data["amount"] as num?)?.toDouble() ?? 0.0;
              }

              final totalBalance = income - expenses;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Total Balance ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                      const Icon(Icons.more_horiz, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$ ${totalBalance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_circle_up_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Income \n\$ ${income.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_circle_down_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Expenses\n\$ ${expenses.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
