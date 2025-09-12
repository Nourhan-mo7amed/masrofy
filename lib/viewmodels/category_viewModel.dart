import 'package:flutter/material.dart';
import 'package:masrofy/models/category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoryView extends ChangeNotifier {
  late final String _uid;

  CategoryView() {
    final user = FirebaseAuth.instance.currentUser;
    _uid = user?.uid ?? "guest"; // 👈 لو مفيش يوزر مسجل يدخل guest
  }

  late final List<CategoryModel> _categories = [
    CategoryModel(id: "food", name: "Food", icon: "🍔", color: Colors.red, userId: _uid),
    CategoryModel(id: "transport", name: "Transport", icon: "🚖", color: Colors.blue, userId: _uid),
    CategoryModel(id: "shopping", name: "Shopping", icon: "🛍️", color: Colors.green, userId: _uid),
    CategoryModel(id: "groceries", name: "Groceries", icon: "🛒", color: Colors.yellow, userId: _uid),
    CategoryModel(id: "rent", name: "Rent", icon: "🏠", color: Colors.purple, userId: _uid),
    CategoryModel(id: "fuel", name: "Fuel", icon: "⛽", color: Colors.pink, userId: _uid),
    CategoryModel(id: "utilities", name: "Utilities", icon: "💡", color: Colors.orange, userId: _uid),
    CategoryModel(id: "subscriptions", name: "Subscriptions", icon: "📺", color: Colors.indigoAccent, userId: _uid),
  ];

  List<CategoryModel> get categories => _categories;

  void toggleCategory(CategoryModel category) {
    category.isSelected = !category.isSelected;
    notifyListeners(); // يعمل rebuild للشاشة
  }

  List<CategoryModel> get selectedCategories {
    return _categories.where((c) => c.isSelected).toList();
  }
}
