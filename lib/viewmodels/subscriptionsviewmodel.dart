import 'package:flutter/material.dart';
import 'package:masrofy/models/expensemodel.dart';

class SubscriptionsViewModel extends ChangeNotifier {
  List<ExpenseModel> expenses = [];

  SubscriptionsViewModel() {
    loadExpenses();
  }

  void loadExpenses() {
    expenses = [
      ExpenseModel(
        title: "Netflix",
        date: "1 Aug 2025",
        amount: "-\$15.99",
        color: Colors.red,
      ),
      ExpenseModel(
        title: "Spotify",
        date: "5 Aug 2025",
        amount: "-\$9.99",
        color: Colors.red,
      ),
    ];
    notifyListeners();
  }
}
