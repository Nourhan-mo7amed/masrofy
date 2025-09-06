import 'package:flutter/material.dart';

class TextFieldProfile extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const TextFieldProfile({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
