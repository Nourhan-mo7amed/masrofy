import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String icon; 
  final Color color; 
  final String userId; // 👈 هنضيف ده
  bool isSelected;

  CategoryModel({
    required this.name,
    required this.icon,
    required this.color,
    required this.userId, // 👈 لازم نمرره
    this.isSelected = false,
    this.id = "",
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "color": color.value, 
        "userId": userId, // 👈 هيبعت الـ UID مع الداتا
        "isSelected": isSelected,
      };

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"] ?? "",
        name: json["name"],
        icon: json["icon"],
        color: Color(json["color"]),
        userId: json["userId"], // 👈 هنرجع الـ UID
        isSelected: json["isSelected"] ?? false,
      );
}
