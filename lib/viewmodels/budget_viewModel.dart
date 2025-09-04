import 'package:flutter/material.dart';
import 'package:masrofy/models/budget_model.dart';

class BudgetViewModel extends ChangeNotifier {
  final TextEditingController amountController = TextEditingController();

  Budget? _budget;
  Budget? get budget => _budget;

  void saveBudget() {
    final text = amountController.text.trim();
    if (text.isEmpty) return;

    final amount = double.tryParse(text);
    if (amount == null) return;

    _budget = Budget(
      icon: Icons.attach_money,
      title: "Monthly Budget",
      date: DateTime.now(),
      amount: amount,
    );

    notifyListeners();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}
