import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xffA8A8A9)),
        suffixIcon: isPassword
            ? const Icon(Icons.visibility, color: Color(0xffA8A8A9))
            : null,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffA8A8A9), width: 1),
        ),
        //enabledBorder:
      ),
    );
  }
}
