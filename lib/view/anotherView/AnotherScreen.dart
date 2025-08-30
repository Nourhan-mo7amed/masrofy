import 'package:flutter/material.dart';
import '../../widgets/another_expenseitem.dart';

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Another",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Expanded(
          child: ListView(
            children: [
             AnotherExpenseItem(
                  title: "Food",
                  date: "22 July 2025",
                  amount: "-\$300.49",
                  color: Colors.red),
              AnotherExpenseItem(
                  title: "Pay to Employees",
                  date: "20 July",
                  amount: "-\$12,400.00",
                  color: Colors.red),
             AnotherExpenseItem(
                  title: "Health Expenditures",
                  date: "14 July 2021",
                  amount: "-\$280.00",
                  color: Colors.red),
              AnotherExpenseItem(
                  title: "Food",
                  date: "22 July 2025",
                  amount: "-\$300.49",
                  color: Colors.red),
              AnotherExpenseItem(
                  title: "Pay to Employees",
                  date: "20 July",
                  amount: "-\$12,400.00",
                  color: Colors.red),
              AnotherExpenseItem(
                  title: "Health Expenditures",
                  date: "14 July 2021",
                  amount: "-\$280.00",
                  color: Colors.red),
              AnotherExpenseItem(
                  title: "Food",
                  date: "22 July 2025",
                  amount: "-\$300.49",
                  color: Colors.red),
              AnotherExpenseItem(
                  title: "Pay to Employees",
                  date: "20 July",
                  amount: "-\$12,400.00",
                  color: Colors.red),
              AnotherExpenseItem(
                  title: "Health Expenditures",
                  date: "14 July 2021",
                  amount: "-\$280.00",
                  color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}

