import 'package:flutter/material.dart';
import 'package:masrofy/core/constants/colors_app.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../widgets/Custom_TextField.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonthlyBudgetScreen extends StatelessWidget {
  const MonthlyBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

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
                      Text(
                        loc.monthlyBudgetTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        loc.monthlyBudgetSubtitle,
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 32),

                      // TextField
                      CustomTextField(
                        hintText: loc.enterAmountHint,
                        icon: Icons.attach_money,
                        controller: null, // assign a controller if needed
                      ),
                      const SizedBox(height: 8),
                      Text(loc.changeLaterNote),

                      const SizedBox(height: 16),

                      // Skip
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/categories');
                        },
                        child: Text(
                          loc.skip,
                          style: const TextStyle(
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
                  child: Text(
                    loc.next,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
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
