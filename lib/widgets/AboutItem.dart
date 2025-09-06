import 'package:flutter/material.dart';

class AboutItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const AboutItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(text, style: TextStyle(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
