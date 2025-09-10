import 'package:flutter/material.dart';
import 'package:masrofy/models/expensemodel.dart';

class AnotherViewModel extends ChangeNotifier {
  List<ExpenseModel> expenses = [];

  AnotherViewModel() {
    loadExpenses();
  }

  void loadExpenses() {
    expenses = [
      ExpenseModel(
        title: "Other Expense 1",
        date: "15 July 2025",
        amount: "-\$200.00",
        color: Colors.red,
      ),
      ExpenseModel(
        title: "Other Expense 2",
        date: "18 July 2025",
        amount: "-\$50.00",
        color: Colors.red,
      ),
    ];
    notifyListeners();
  }
}
