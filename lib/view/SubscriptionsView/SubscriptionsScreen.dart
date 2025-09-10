import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/viewmodels/subscriptionsviewmodel.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Subscriptions extends StatelessWidget {
  const Subscriptions({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final subscriptionsVM = context.watch<SubscriptionsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.subscriptionsTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: subscriptionsVM.expenses.length,
        itemBuilder: (context, index) {
          final expense = subscriptionsVM.expenses[index];
          return ListTile(
            title: Text(expense.title),
            subtitle: Text(expense.date),
            trailing: Text(
              expense.amount,
              style: TextStyle(color: expense.color),
            ),
          );
        },
      ),
    );
  }
}
