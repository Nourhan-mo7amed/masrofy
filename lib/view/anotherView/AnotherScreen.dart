import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/viewmodels/anotherviewmodel.dart';
import 'package:masrofy/viewmodels/shopingviewmodel.dart';
import 'package:provider/provider.dart';
import '../../widgets/another_expenseitem.dart';

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final anotherVM = context.watch<AnotherViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.another,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: anotherVM.expenses.length,
        itemBuilder: (context, index) {
          final expense = anotherVM.expenses[index];
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
