import 'package:flutter/material.dart';

class Budget {
  IconData icon;
  String title;
  DateTime date;
  double amount;

  Budget({
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
  });
}
