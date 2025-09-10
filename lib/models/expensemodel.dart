import 'package:flutter/material.dart';

class ExpenseModel {
  final String title;
  final String date;
  final String amount;
  final Color color;

  ExpenseModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.color,
  });
}
