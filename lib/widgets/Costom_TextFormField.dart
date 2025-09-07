import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    required this.controller,
    this.onChanged,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool sec = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your ${widget.hintText}";
        }
        return null;
      },
      obscureText: widget.isPassword == true ? sec : false,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: Color(0xffA8A8A9)),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    sec = !sec;
                  });
                },
                icon: Icon(
                  sec ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xffA8A8A9),
                ),
              )
            : null,
        hintText: widget.hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffA8A8A9), width: 1),
        ),
        //enabledBorder:
      ),
    );
  }
}
