import 'package:flutter/material.dart';
import 'package:masrofy/models/transaction_model.dart';

class TransactionViewmodel extends ChangeNotifier {
  final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  void addTransaction(TransactionModel transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  List<TransactionModel> get expenses =>
      _transactions.where((tx) => tx.type == "expense").toList();
  List<TransactionModel> get incomes =>
      _transactions.where((tx) => tx.type == "income").toList();
}
