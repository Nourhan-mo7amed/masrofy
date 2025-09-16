import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  final Function(int) onRate;

  const RatingStars({
    super.key,
    required this.rating,
    required this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Color(0xFF6155F5),
            size: 30,
          ),
          onPressed: () => onRate(index + 1),
        );
      }),
    );
  }
}
