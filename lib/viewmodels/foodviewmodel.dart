import 'package:flutter/material.dart';
import 'package:masrofy/models/expensemodel.dart';

class FoodViewModel extends ChangeNotifier {
  List<ExpenseModel> expenses = [];

  FoodViewModel() {
    loadExpenses();
  }

  void loadExpenses() {
    expenses = [
      ExpenseModel(
        title: "Food",
        date: "22 July 2025",
        amount: "-\$300.49",
        color: Colors.red,
      ),
      ExpenseModel(
        title: "Pay to Employees",
        date: "20 July",
        amount: "-\$12,400.00",
        color: Colors.red,
      ),
      ExpenseModel(
        title: "Health",
        date: "14 July 2021",
        amount: "-\$280.00",
        color: Colors.red,
      ),
    ];
    notifyListeners();
  }
}
