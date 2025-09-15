import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String amount;

  const ExpenseItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(14),
     decoration: BoxDecoration(
  color: Theme.of(context).brightness == Brightness.dark
      ? Colors.white.withOpacity(0.1) // 🟢 أبيض شفاف في الدارك مود
      : Colors.white, // 🟢 أبيض كامل في اللايت مود
  borderRadius: BorderRadius.circular(14),
  // boxShadow: [
  //   BoxShadow(
  //     color: Colors.grey.shade200,
  //     blurRadius: 6,
  //     spreadRadius: 2,
  //   ),
  // ],
),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  //color: Colors.black,
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
