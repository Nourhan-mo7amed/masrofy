import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/viewmodels/shopingviewmodel.dart';
import 'package:provider/provider.dart';
import '../../widgets/shopping_expenseitem.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final shoppingVM = context.watch<ShoppingViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.shoppingTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: shoppingVM.expenses.length,
        itemBuilder: (context, index) {
          final expense = shoppingVM.expenses[index];
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
