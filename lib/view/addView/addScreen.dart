import 'package:flutter/material.dart';
import 'package:masrofy/core/routes/routes.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/view/addView/widgets/last_expenses-listView.dart';
import 'package:masrofy/viewmodels/transaction_viewModel.dart';
import 'package:provider/provider.dart';
import '../../widgets/add_expenseitem.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final txViewModel = Provider.of<TransactionViewmodel>(context);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/addIncome');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsetsDirectional.only(end: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(50, 209, 196, 233),
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
                      margin: const EdgeInsetsDirectional.only(end: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(50, 255, 224, 178),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.allTransaction);
                  },
                  child: Text(
                    loc.seeAll,
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(child: LastExpensesListView()),
          ],
        ),
      ),
    );
  }
}
