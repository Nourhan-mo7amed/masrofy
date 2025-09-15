import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/repositories/auth_repsitories.dart';
import 'package:masrofy/view/loginView/custom_login_form.dart';
import '../../widgets/social_Icon.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              // Welcome Text
              Text(
                loc.welcomeBack,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                loc.loginDescription,
                style: const TextStyle(fontSize: 14, ),
              ),
              const SizedBox(height: 32),

              // Custom Login Form
              const CustomLoginForm(),
              const SizedBox(height: 24),

              // Or login with
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      loc.orLoginWith,
                     
                    ),
                  ),
                  const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 24),

              // Social Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialIcon(
                    imagePath: 'assets/images/google.png',
                    onTap: () async {
                      final user = await AuthService().signInWithGoogle();
                      if (user != null) {
                        print('✅ Logged in as: ${user.displayName}');
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        print('❌ Google Sign-In Failed');
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  const SocialIcon(imagePath: 'assets/images/facebook.png'),
                  const SizedBox(width: 16),
                  const SocialIcon(imagePath: 'assets/images/apple.png'),
                ],
              ),
              const SizedBox(height: 24),

              // Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(loc.dontHaveAccount),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      loc.signUp,
                      style: const TextStyle(
                        color: Color(0xFF6155F5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
