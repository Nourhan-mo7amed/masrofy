import 'package:flutter/material.dart';
import '../../widgets/tapButtom.dart';
import '../../view/edittransactionView/EditTransactionScreen.dart';
import '../../widgets/transaction_details_bottomsheet.dart';

class AlltransactionScreen extends StatefulWidget {
  const AlltransactionScreen({super.key});

  @override
  _AlltransactionScreen createState() => _AlltransactionScreen();
}

class _AlltransactionScreen extends State<AlltransactionScreen> {
  int selectedTab = 0;

  final transaction = {
    "title": "Food",
    "date": "22 July 2025",
    "category": "Food",
    "description": "Dinner with family",
    "amount": 300.49,
  };

  void _showTransactionDetails(
    BuildContext context,
    Map<String, dynamic> transaction,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return TransactionDetailsBottomSheet(transaction: transaction);
      },
    );
  }

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
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TabButton(
                      text: "Expenses",
                      isSelected: selectedTab == 0,
                      onTap: () {
                        setState(() {
                          selectedTab = 0;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TabButton(
                      text: "Income",
                      isSelected: selectedTab == 1,
                      onTap: () {
                        setState(() {
                          selectedTab = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 1,
              color: Colors.white,
              child: ListTile(
                onTap: () => _showTransactionDetails(context, transaction),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.attach_money, color: Colors.grey, size: 22),
                ),
                title: Text(transaction["title"] as String),
                subtitle: Text(transaction["date"] as String),
                trailing: Text(
                  "\$${transaction["amount"]}",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
