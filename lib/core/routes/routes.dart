import 'package:flutter/material.dart';
import '../../view/intro/splash_screen.dart';
import '../../view/categoriesView/CategoriesScreen.dart';
import '../../view/monthlyBudgetView/MonthlyBudget_Screen.dart';
import '../../view/forgotPasswordView/forgotPW_screen.dart';
import '../../view/loginView/login_screen.dart';
import '../../view/registerView/register_screen.dart';
import '../../view/setupCompleteView/setup_compelete.dart';
import '../../view/intro/onbording screens/onbording.dart';
import '../../view/homeView/home.dart';
import '../../view/addView/addScreen.dart';
import '../../view/allTransactionView/all_transactionScreen.dart';
import '../../view/profileView/profileScreen.dart';
import '../../view/add_ExpenseView/add_ExpenseScreen.dart';
import '../../view/add_incomeView/add_Income_Screen.dart';
import '../../view/shoppingView/shoppingscreen.dart';
import '../../view/statisticsView/statisticsScreen.dart';
import '../../view/SubscriptionsView/SubscriptionsScreen.dart';
import '../../view/foodView/foodscreen.dart';
import '../../view/anotherView/AnotherScreen.dart';
import '../../view/privacypolicyView/privacypolicyScreen.dart';
import '../../view/settingsView/settingScreen.dart';
import '../../view/feedbackView/feedbackScreen.dart';
import '../../view/editprofileView/editprofileScreen.dart';
import '../../view/helpView/helpScreen.dart';
import '../../view/aboutView/aboutScreen.dart';
import '../../view/passwordManagerView/passwordmanagerScreen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static const String monthlyBudget = '/monthlyBudget';
  static const String categories = '/categories';
  static const String setupComplete = '/setupComplete';
  static const String home = '/home';
  static const String add = '/add';
  static const String allTransaction = '/allTransaction';
  static const String profile = '/profile';
  static const String addExpense = '/addExpense';
  static const String addIncome = '/addIncome';
  static const String shopping = '/shopping';
  static const String statistics = '/statistics';
  static const String subscriptions = '/subscriptions';
  static const String food = '/food';
  static const String another = '/another';
  static const String privacypolicy = '/privacypolicy';
  static const String settings = '/settings';
  static const String feedback = '/feedback';
  static const String editprofile = '/editprofile';
  static const String help = '/help';
  static const String about = '/about';
  static const String passwordManager = '/passwordManager';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnBoardingScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    monthlyBudget: (context) => const MonthlyBudgetScreen(),
    categories: (context) => const SpendingCategoriesScreen(),
    setupComplete: (context) => const SetupCompleteScreen(),
    home: (context) => const HomeScreen(),
    add: (context) => const AddScreen(),
    allTransaction: (context) => const AlltransactionScreen(),
    profile: (context) => const Profilescreen(),
    addExpense: (context) => AddExpenseScreen(),
    addIncome: (context) => AddIncomeScreen(),
    shopping: (context) => const ShoppingScreen(),
    statistics: (context) => const StatisticsScreen(),
    subscriptions: (context) => const Subscriptions(),
    food: (context) => const FoodScreen(),
    another: (context) => const AnotherScreen(),
    privacypolicy: (context) => const PrivacyPolicyScreen(),
    settings: (context) => const SettingsScreen(),
    feedback: (context) => const FeedbackScreen(),
    editprofile: (context) => const EditProfileScreen(),
    help: (context) => const HelpScreen(),
    about: (context) => const AboutScreen(),
    passwordManager: (context) => PasswordManager(),
  };
}
