import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/add_expenseitem.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          title: Text(
            loc.add,
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/addIncome');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.account_balance_wallet,
                            size: 40,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loc.addIncome,
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.shopping_bag,
                            size: 40,
                            color: Colors.orange,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loc.addExpense,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loc.lastExpenses,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  loc.seeAll,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  AddExpenseItem(
                    title: loc.food,
                    date: "22 July 2025",
                    amount: "-\$300.49",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: loc.payToEmployees,
                    date: "20 July",
                    amount: "-\$12,400.00",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: loc.healthExpenditures,
                    date: "14 July 2021",
                    amount: "-\$280.00",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: loc.food,
                    date: "22 July 2025",
                    amount: "-\$300.49",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: loc.payToEmployees,
                    date: "20 July",
                    amount: "-\$12,400.00",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: loc.healthExpenditures,
                    date: "14 July 2021",
                    amount: "-\$280.00",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: loc.food,
                    date: "22 July 2025",
                    amount: "-\$300.49",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: loc.payToEmployees,
                    date: "20 July",
                    amount: "-\$12,400.00",
                    color: Colors.red,
                  ),
                  AddExpenseItem(
                    title: loc.healthExpenditures,
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
