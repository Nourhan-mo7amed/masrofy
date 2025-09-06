import 'package:flutter/material.dart';
import '../../widgets/add_expenseitem.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          title: Text("Add", style: TextStyle(fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/addIncome');
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            size: 40,
                            color: Colors.deepPurple,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Add Income",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/addExpense');
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            size: 40,
                            color: Colors.orange,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Add Expense",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Last Expenses",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text("See All", style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  AddExpenseItem(
                    title: "Food",
                    date: "22 July 2025",
                    amount: "-\$300.49",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: "Pay to Employees",
                    date: "20 July",
                    amount: "-\$12,400.00",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: "Health Expenditures",
                    date: "14 July 2021",
                    amount: "-\$280.00",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: "Food",
                    date: "22 July 2025",
                    amount: "-\$300.49",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: "Pay to Employees",
                    date: "20 July",
                    amount: "-\$12,400.00",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: "Health Expenditures",
                    date: "14 July 2021",
                    amount: "-\$280.00",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: "Food",
                    date: "22 July 2025",
                    amount: "-\$300.49",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: "Pay to Employees",
                    date: "20 July",
                    amount: "-\$12,400.00",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: "Health Expenditures",
                    date: "14 July 2021",
                    amount: "-\$280.00",
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
