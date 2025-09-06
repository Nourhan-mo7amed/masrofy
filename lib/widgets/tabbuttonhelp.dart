import 'package:flutter/material.dart';

class TabButtonhelp extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const TabButtonhelp({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6C63FF) : Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Color(0xFF6155F5),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
