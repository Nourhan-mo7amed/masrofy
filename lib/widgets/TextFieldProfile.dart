import 'package:flutter/material.dart';

class TextFieldProfile extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const TextFieldProfile({
    super.key,
    required this.label,
    required this.hint,
    required this.controller, required Color fillColor, required Color textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
