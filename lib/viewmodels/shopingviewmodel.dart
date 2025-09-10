import 'package:flutter/material.dart';
import 'package:masrofy/models/expensemodel.dart';

class ShoppingViewModel extends ChangeNotifier {
  List<ExpenseModel> expenses = [];

  ShoppingViewModel() {
    loadExpenses();
  }

  void loadExpenses() {
    expenses = [
      ExpenseModel(
        title: "Shopping Item 1",
        date: "10 July 2025",
        amount: "-\$100.00",
        color: Colors.red,
      ),
      ExpenseModel(
        title: "Shopping Item 2",
        date: "12 July 2025",
        amount: "-\$50.00",
        color: Colors.red,
      ),
    ];
    notifyListeners();
  }
}
