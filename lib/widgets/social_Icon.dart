import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final String imagePath;
  const SocialIcon({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Image.asset(imagePath, fit: BoxFit.contain),
    );
  }
}
