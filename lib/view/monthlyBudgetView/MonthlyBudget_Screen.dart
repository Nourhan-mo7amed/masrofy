import 'package:flutter/material.dart';
import 'package:masrofy/core/constants/colors_app.dart';
import '../../widgets/Custom_TextField.dart';

class MonthlyBudgetScreen extends StatelessWidget {
  const MonthlyBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 32),

                      // Illustration
                      Center(
                        child: Image.asset(
                          'assets/images/budget.png',
                          height: 180,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Title
                      const Text(
                        "Monthly Budget Goal",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Do you have a monthly spending goal?",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 32),

                      // TextField
                      const CustomTextField(
                        hintText: 'Enter amount',
                        icon: Icons.attach_money,
                      ),
                      const SizedBox(height: 8),
                      Text('You can always change this later.'),

                      const SizedBox(height: 16),

                      // Skip
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/categories');
                        },
                        child: const Text(
                          "SKIP",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Next Button fixed at bottom
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
                    Navigator.pushNamed(context, '/categories');
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
