import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../widgets/Buildcategorycard.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          title: Text(
            loc.statisticsTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: loc.monthly,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: loc.monthly,
                        child: Text(loc.monthly),
                      ),
                    ],
                    onChanged: (val) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pie Chart
            SizedBox(
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 70,
                      sections: [
                        PieChartSectionData(value: 300.4, color: Colors.blue, title: ""),
                        PieChartSectionData(value: 2100, color: Colors.red, title: ""),
                        PieChartSectionData(value: 2700, color: Colors.orange, title: ""),
                        PieChartSectionData(value: 500, color: Colors.purple, title: ""),
                      ],
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
                      const Text(
                        "\$3,350.00",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Category Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.0,
              children: [
                BuildCategoryCard(
                  title: loc.another,
                  amount: "\$300.4",
                  description: "Mauris hendrerit mollis bibendum quisque.",
                  color: Colors.blue,
                ),
                BuildCategoryCard(
                  title: loc.subscriptions,
                  amount: "\$2,100",
                  description: "Porin sagittis imperdiet egestas aenean maxi",
                  color: Colors.red,
                ),
                BuildCategoryCard(
                  title: loc.shopping,
                  amount: "\$2,700",
                  description: "Maecenas quis purus at metus posuere dapib.",
                  color: Colors.orange,
                ),
                BuildCategoryCard(
                  title: loc.food,
                  amount: "\$500",
                  description: "Maecenas quis purus at metus posuere dapib.",
                  color: Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Recent Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(loc.recent, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(loc.seeAll, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
