import 'package:flutter/material.dart';

class ChipsSection extends StatelessWidget {
  final String title;
  final List<String> options;
  final List<String> selectedOptions;
  final Function(String, bool) onSelected;

  const ChipsSection({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOptions,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
         SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 9,
          children: options.map((item) {
            final selected = selectedOptions.contains(item);
            return ChoiceChip(
              label: Text(item),
              selected: selected,
              showCheckmark: false,
              selectedColor:  Color(0xFF6155F5),
              backgroundColor: Color.fromARGB(255, 235, 242, 247),
              labelStyle: TextStyle(
                color: selected ? Colors.white : Color(0xFF6155F5),
              ),
              onSelected: (value) => onSelected(item, value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
