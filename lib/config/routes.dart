import 'package:flutter/material.dart';
import '../../features/intro/splash_screen.dart';
import '../features/auth/ui/screens/CategoriesScreen.dart';
import '../features/auth/ui/screens/MonthlyBudget_Screen.dart';
import '../features/auth/ui/screens/forgotPW_screen.dart';
import '../features/auth/ui/screens/login_screen.dart';
import '../features/auth/ui/screens/register_screen.dart';
import '../features/auth/ui/screens/setup_compelete.dart';
import '../features/intro/onbording screens/onbording.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword'; 
  static const String monthlyBudget = '/monthlyBudget';
  static const String categories = '/categories';
  static const String setupComplete = '/setupComplete';

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
