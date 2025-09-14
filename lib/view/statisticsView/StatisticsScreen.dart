import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/Buildcategorycard.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "Statistics",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: "Monthly",
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: "Monthly",
                        child: Text("Monthly"),
                      ),
                    ],
                    onChanged: (val) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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
                        PieChartSectionData(
                          value: 300.4,
                          color: Colors.blue,
                          title: "",
                        ),
                        PieChartSectionData(
                          value: 2100,
                          color: Colors.red,
                          title: "",
                        ),
                        PieChartSectionData(
                          value: 2700,
                          color: Colors.orange,
                          title: "",
                        ),
                        PieChartSectionData(
                          value: 500,
                          color: Colors.purple,
                          title: "",
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Balance",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
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
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.0,
              children: [
                BuildCategoryCard(
                  title: "Another",
                  amount: "\$300.4",
                  description: "Mauris hendrerit mollis bibendum quisque.",
                  color: Colors.blue,
                ),
                BuildCategoryCard(
                  title: "Subscriptions",
                  amount: "\$2,100",
                  description: "Porin sagittis imperdiet egestas aenean maxi",
                  color: Colors.red,
                ),
                BuildCategoryCard(
                  title: "Shopping",
                  amount: "\$2,700",
                  description: "Maecenas quis purus at metus posuere dapib.",
                  color: Colors.orange,
                ),
                BuildCategoryCard(
                  title: "Food",
                  amount: "\$500",
                  description: "Maecenas quis purus at metus posuere dapib.",
                  color: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("See All", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
