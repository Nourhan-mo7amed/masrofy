import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/food_expenseitem.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.foodTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Expanded(
          child: ListView(
            children: [
              FoodExpenseItem(
                title: loc.foodTitle,
                date: "22 July 2025",
                amount: "-\$300.49",
                color: Colors.red,
              ),
              FoodExpenseItem(
                title: loc.payToEmployeesTitle,
                date: "20 July",
                amount: "-\$12,400.00",
                color: Colors.red,
              ),
              FoodExpenseItem(
                title: loc.healthExpendituresTitle,
                date: "14 July 2021",
                amount: "-\$280.00",
                color: Colors.red,
              ),
              FoodExpenseItem(
                title: loc.foodTitle,
                date: "22 July 2025",
                amount: "-\$300.49",
                color: Colors.red,
              ),
              FoodExpenseItem(
                title: loc.payToEmployeesTitle,
                date: "20 July",
                amount: "-\$12,400.00",
                color: Colors.red,
              ),
              FoodExpenseItem(
                title: loc.healthExpendituresTitle,
                date: "14 July 2021",
                amount: "-\$280.00",
                color: Colors.red,
              ),
              FoodExpenseItem(
                title: loc.foodTitle,
                date: "22 July 2025",
                amount: "-\$300.49",
                color: Colors.red,
              ),
              FoodExpenseItem(
                title: loc.payToEmployeesTitle,
                date: "20 July",
                amount: "-\$12,400.00",
                color: Colors.red,
              ),
              FoodExpenseItem(
                title: loc.healthExpendituresTitle,
                date: "14 July 2021",
                amount: "-\$280.00",
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
