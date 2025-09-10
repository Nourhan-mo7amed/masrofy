import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:masrofy/models/category_model.dart';
import '../../widgets/Buildcategorycard.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  /// 🔹 نفس الكاتيجوريز (لازم تطابق AddExpenseScreen)
  final List<CategoryModel> categories =  [
    CategoryModel(id: "food", name: "Food", icon: "🍔", color: Colors.purple),
    CategoryModel(id: "shopping", name: "Shopping", icon: "🛍️", color: Colors.orange),
    CategoryModel(id: "bills", name: "Bills", icon: "📄", color: Colors.red),
    CategoryModel(id: "transport", name: "Transport", icon: "🚗", color: Colors.blue),
  ];

  Stream<Map<String, double>> _getCategoryTotals() {
    return FirebaseFirestore.instance
        .collection("expenses")
        .snapshots()
        .map((snapshot) {
      final Map<String, double> totals = {};
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final String categoryId = data["categoryId"] ?? "other";
        final double amount = (data["amount"] as num?)?.toDouble() ?? 0.0;

        totals[categoryId] = (totals[categoryId] ?? 0) + amount;
      }
      return totals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistics", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: StreamBuilder<Map<String, double>>(
        stream: _getCategoryTotals(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final totals = snapshot.data!;
          final totalAmount = totals.values.fold(0.0, (a, b) => a + b);

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
                          sections: totals.entries.map((entry) {
                            final cat = categories.firstWhere(
                              (c) => c.id == entry.key,
                              orElse: () => CategoryModel(
                                  id: "other",
                                  name: "Other",
                                  icon: "❓",
                                  color: Colors.grey),
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
                          const Text("Total Balance", style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(
                            "\$${totalAmount.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
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
                  children: totals.entries.map((entry) {
                    final cat = categories.firstWhere(
                      (c) => c.id == entry.key,
                      orElse: () => CategoryModel(
                          id: "other",
                          name: "Other",
                          icon: "❓",
                          color: Colors.grey),
                    );
                    return BuildCategoryCard(
                      title: cat.name,
                      amount: "\$${entry.value.toStringAsFixed(2)}",
                      description: "Spending in ${cat.name}",
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
