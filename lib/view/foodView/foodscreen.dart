import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/viewmodels/foodviewmodel.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final foodVM = context.watch<FoodViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.foodTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: foodVM.expenses.length,
        itemBuilder: (context, index) {
          final expense = foodVM.expenses[index];
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
