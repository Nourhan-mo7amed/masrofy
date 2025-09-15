import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:masrofy/models/category_model.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../widgets/Buildcategorycard.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late List<CategoryModel> categories;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final loc = AppLocalizations.of(context)!;

    categories = [
      CategoryModel(
        id: "food",
        name: loc.food,
        icon: "🍔",
        color: Colors.purple,
        userId: '',
      ),
      CategoryModel(
        id: "shopping",
        name: loc.shopping,
        icon: "🛍️",
        color: Colors.orange,
        userId: '',
      ),
      CategoryModel(
        id: "bills",
        name: loc.expenses, // 🔹 مفيش bills في الترانسليشن، استخدمت "expenses"
        icon: "📄",
        color: Colors.red,
        userId: '',
      ),
      CategoryModel(
        id: "transport",
        name: loc.another, // 🔹 برضه مفيش transport، ممكن تضيفها في JSON لو عايز
        icon: "🚗",
        color: Colors.blue,
        userId: '',
      ),
    ];
  }

  Stream<Map<String, dynamic>> _getTotals() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    final expensesStream = FirebaseFirestore.instance
        .collection("expenses")
        .where("userId", isEqualTo: uid)
        .snapshots();

    final incomesStream = FirebaseFirestore.instance
        .collection("incomes")
        .where("userId", isEqualTo: uid)
        .snapshots();

    return expensesStream.asyncMap((expenseSnap) async {
      final incomeSnap = await incomesStream.first;

      double totalExpenses = 0;
      final Map<String, double> categoryTotals = {};
      for (var doc in expenseSnap.docs) {
        final data = doc.data();
        final String categoryId = data["categoryId"] ?? "other";
        final double amount = (data["amount"] as num?)?.toDouble() ?? 0.0;

        totalExpenses += amount;
        categoryTotals[categoryId] = (categoryTotals[categoryId] ?? 0) + amount;
      }

      double totalIncome = 0;
      for (var doc in incomeSnap.docs) {
        final data = doc.data();
        final double amount = (data["amount"] as num?)?.toDouble() ?? 0.0;
        totalIncome += amount;
      }

      return {
        "categoryTotals": categoryTotals,
        "totalIncome": totalIncome,
        "totalExpenses": totalExpenses,
        "balance": totalIncome - totalExpenses,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.statistics,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: _getTotals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                loc.noStatistics,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          final categoryTotals =
              snapshot.data!["categoryTotals"] as Map<String, double>;
          final totalIncome = snapshot.data!["totalIncome"] as double;
          final totalExpenses = snapshot.data!["totalExpenses"] as double;
          final balance = snapshot.data!["balance"] as double;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 70,
                          sections: categoryTotals.entries.map((entry) {
                            final cat = categories.firstWhere(
                              (c) => c.id == entry.key,
                              orElse: () => CategoryModel(
                                id: "other",
                                name: loc.other,
                                icon: "❓",
                                color: Colors.grey,
                                userId: '',
                              ),
                            );
                            return PieChartSectionData(
                              value: entry.value,
                              color: cat.color,
                              title: "",
                            );
                          }).toList(),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            loc.totalBalance,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "\$${balance.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${loc.income}: \$${totalIncome.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Colors.green[600],
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${loc.expenses}: \$${totalExpenses.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Colors.red[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.0,
                  children: categoryTotals.entries.map((entry) {
                    final cat = categories.firstWhere(
                      (c) => c.id == entry.key,
                      orElse: () => CategoryModel(
                        id: "other",
                        name: loc.other,
                        icon: "❓",
                        color: Colors.grey,
                        userId: '',
                      ),
                    );
                    return BuildCategoryCard(
                      title: cat.name,
                      amount: "\$${entry.value.toStringAsFixed(2)}",
                      description: "${loc.spendingIn} ${cat.name}",
                      color: cat.color,
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
