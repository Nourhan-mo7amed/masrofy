import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback? onTap;

  const ProfileCard({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
