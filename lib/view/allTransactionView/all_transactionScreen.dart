import 'package:flutter/material.dart';
import 'package:masrofy/view/allTransactionView/custom_expeneses_listView.dart';
import 'package:masrofy/view/allTransactionView/custom_income_listView.dart';
import '../../widgets/tapButtom.dart';

class AlltransactionScreen extends StatefulWidget {
  const AlltransactionScreen({super.key});
  @override
  _AlltransactionScreen createState() => _AlltransactionScreen();
}

class _AlltransactionScreen extends State<AlltransactionScreen> {
  bool selectedTab = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "All Transaction",
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TabButton(
                      text: "Expenses",
                      isSelected: selectedTab == false,
                      onTap: () {
                        setState(() {
                          selectedTab = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TabButton(
                      text: "Income",
                      isSelected: selectedTab == true,
                      onTap: () {
                        setState(() {
                          selectedTab = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
           selectedTab==false? CustomExpamdedExpenses():CustomExpandedIncomes(),
          ],
        ),
      ),
    );
  }
}


