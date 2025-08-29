import 'package:flutter/material.dart';
import '../../view/intro/splash_screen.dart';
import '../../view/categoriesView/CategoriesScreen.dart';
import '../../view/monthlyBudgetView/MonthlyBudget_Screen.dart';
import '../../view/forgotPasswordView/forgotPW_screen.dart';
import '../../view/loginView/login_screen.dart';
import '../../view/registerView/register_screen.dart';
import '../../view/setupCompleteView/setup_compelete.dart';
import '../../view/intro/onbording screens/onbording.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword'; 
  static const String monthlyBudget = '/monthlyBudget';
  static const String categories = '/categories';
  static const String setupComplete = '/setupComplete';
//hallo
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnBoardingScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    monthlyBudget: (context) => const MonthlyBudgetScreen(),
    categories: (context) => const SpendingCategoriesScreen(),
    setupComplete: (context) => const SetupCompleteScreen(),
  };
}
