import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/viewmodels/Auth_ViewModel.dart';
import 'package:masrofy/viewmodels/budget_viewModel.dart';
import 'package:masrofy/viewmodels/category_viewModel.dart';
import 'package:masrofy/viewmodels/settings_viewmodel.dart';

import 'package:masrofy/viewmodels/transaction_viewModel.dart';
import 'package:provider/provider.dart';
import 'core/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryView()),
        ChangeNotifierProvider(create: (_) => TransactionViewmodel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider(create: (_) => BudgetViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryView()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsVM = context.watch<SettingsViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settingsVM.settings.darkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      locale: const Locale('en'),

      // 👇 لازم عشان الترجمة تشتغل
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
    );
  }
}
