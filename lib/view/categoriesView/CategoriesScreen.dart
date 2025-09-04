import 'package:flutter/material.dart';
import 'package:masrofy/core/constants/colors_app.dart';
import 'package:masrofy/viewmodels/category_viewModel.dart';
import 'package:provider/provider.dart';

class SpendingCategoriesScreen extends StatefulWidget {
  const SpendingCategoriesScreen({super.key});

  @override
  State<SpendingCategoriesScreen> createState() =>
      _SpendingCategoriesScreenState();
}

class _SpendingCategoriesScreenState extends State<SpendingCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryView = Provider.of<CategoryView>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 32),

              // Illustration
              Center(
                child: Image.asset('assets/images/categories.png', height: 180),
              ),
              const SizedBox(height: 24),

              const Text(
                "Spending Categories",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "What do you spend most on?",
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Categories Grid
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: categoryView.categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 3.5,
                  ),
                  itemBuilder: (context, index) {
                    final category = categoryView.categories[index];
                    final isSelected = category.isSelected;

                    return OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            isSelected ? AppColors.primary : Colors.white,
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black,
                        side: BorderSide(
                          color: isSelected ? AppColors.primary : Colors.grey,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        categoryView.toggleCategory(category);
                      },
                      child: Text("${category.icon} ${category.name}"),
                    );
                  },
                ),
              ),

              // Skip
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/setupComplete');
                },
                child: const Text(
                  "SKIP",
                  style: TextStyle(color: Colors.black54),
                ),
              ),

              // Next Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    debugPrint(
                      "Selected Categories: ${categoryView.selectedCategories}",
                    ); // هنا تقدر تبعت الداتا للسيرفر
                    Navigator.pushNamed(context, '/setupComplete');
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
