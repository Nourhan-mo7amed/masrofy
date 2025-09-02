import 'package:flutter/material.dart';

class ShoppingExpenseitem extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final Color color;

  const ShoppingExpenseitem({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.attach_money, color: Colors.grey, size: 22),
        ),
        title: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(date, style: TextStyle(fontSize: 12)),
        trailing: Text(amount,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }
}
