import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../widgets/shopping_expenseitem.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.shoppingTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            ShoppingExpenseitem(
              title: loc.food,
              date: "22 July 2025",
              amount: "-\$300.49",
              color: Colors.red,
            ),
            ShoppingExpenseitem(
              title: loc.payToEmployees,
              date: "20 July",
              amount: "-\$12,400.00",
              color: Colors.red,
            ),
            ShoppingExpenseitem(
              title: loc.healthExpenditures,
              date: "14 July 2021",
              amount: "-\$280.00",
              color: Colors.red,
            ),
            ShoppingExpenseitem(
              title: loc.food,
              date: "22 July 2025",
              amount: "-\$300.49",
              color: Colors.red,
            ),
            ShoppingExpenseitem(
              title: loc.payToEmployees,
              date: "20 July",
              amount: "-\$12,400.00",
              color: Colors.red,
            ),
            ShoppingExpenseitem(
              title: loc.healthExpenditures,
              date: "14 July 2021",
              amount: "-\$280.00",
              color: Colors.red,
            ),
            ShoppingExpenseitem(
              title: loc.food,
              date: "22 July 2025",
              amount: "-\$300.49",
              color: Colors.red,
            ),
            ShoppingExpenseitem(
              title: loc.payToEmployees,
              date: "20 July",
              amount: "-\$12,400.00",
              color: Colors.red,
            ),
            ShoppingExpenseitem(
              title: loc.healthExpenditures,
              date: "14 July 2021",
              amount: "-\$280.00",
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
