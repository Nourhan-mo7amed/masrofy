import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../core/constants/colors_app.dart';
import 'onbording screens/onbording.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/animations/logo2.json", height: 400),
            AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: _opacity,
              child: Text(
                'Masrofy',
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
