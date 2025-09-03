import 'package:flutter/material.dart';
import 'package:masrofy/models/category_model.dart';

class CategoryView extends ChangeNotifier {
  final List<CategoryModel> _categories = [
    CategoryModel(name: "Food", icon: "🍔", color: Colors.red),
    CategoryModel(name: "Transport", icon: "🚖", color: Colors.blue),
    CategoryModel(name: "Shopping", icon: "🛍️", color: Colors.green),
    CategoryModel(name: "Groceries", icon: "🛒", color: Colors.yellow),
    CategoryModel(name: "Rent", icon: "🏠", color: Colors.purple),
    CategoryModel(name: "Fuel", icon: "🛍️", color: Colors.pink),
    CategoryModel(name: "Utilities", icon: "💡", color: Colors.orange),
    CategoryModel(
      name: "Subscriptions",
      icon: "📺",
      color: Colors.indigoAccent,
    ),
  ];

  List<CategoryModel> get categories => _categories;

  void toggleCategory(CategoryModel category) {
    category.isSelected = !category.isSelected;
    notifyListeners(); // عشان يعمل rebuild للشاشة
  }

  List<CategoryModel> get selectedCategories {
    final selected = _categories.where((c) => c.isSelected);
    return selected.toList();
  }
}
