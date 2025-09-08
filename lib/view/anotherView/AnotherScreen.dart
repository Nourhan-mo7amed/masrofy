import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/viewmodels/transaction_viewModel.dart';
import 'package:provider/provider.dart';
import '../../widgets/another_expenseitem.dart';
import 'package:intl/intl.dart';

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final txViewModel = Provider.of<TransactionViewmodel>(context);
    final expenses = txViewModel.expenses;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.another,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: expenses.isEmpty
            ? Center(child: Text("No Transactions"))
            : ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final tx = expenses[index];
                  final formattedDate = DateFormat(
                    'dd MMM yyyy',
                  ).format(tx.date);
                  return AnotherExpenseItem(
                    title: tx.title,
                    date: formattedDate,
                    amount: "-\$${tx.amount.toStringAsFixed(2)}",
                    color: Colors.red,
                  );
                },
              ),
      ),
    );
  }
}
