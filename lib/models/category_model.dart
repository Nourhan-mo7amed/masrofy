import 'dart:ui';

class CategoryModel {
  final String name;
  final String icon;
  final Color color;
  bool isSelected;

  CategoryModel({
    required this.name,
    this.isSelected = false,
    required this.icon,
    required this.color,
  });
}
