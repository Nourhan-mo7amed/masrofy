import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String icon; 
  final Color color; 
  bool isSelected;

  CategoryModel({
    required this.name,
    required this.icon,
    required this.color,
    this.isSelected = false,
    this.id = "",
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "color": color.value, 
        "isSelected": isSelected,
      };

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        color: Color(json["color"]), 
        isSelected: json["isSelected"] ?? false,
      );
}
