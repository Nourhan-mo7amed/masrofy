import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/viewmodels/Auth_ViewModel.dart';
import 'package:masrofy/widgets/Costom_TextFormField.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomLoginForm extends StatefulWidget {
  const CustomLoginForm({super.key});

  @override
  State<CustomLoginForm> createState() => _CustomLoginFormState();
}

class _CustomLoginFormState extends State<CustomLoginForm> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? email, password;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final loc = AppLocalizations.of(context)!;

    return Form(
      key: _globalKey,
      child: Column(
        children: [
          // Email label
          Text(
            loc.emailLabel,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: _emailController,
            hintText: loc.emailHint,
            icon: Icons.email_outlined,
            onChanged: (value) => email = value,
          ),
          const SizedBox(height: 16),

          // Password label
          Text(
            loc.passwordLabel,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: _passwordController,
            hintText: loc.passwordHint,
            icon: Icons.lock_outline,
            isPassword: true,
            onChanged: (value) => password = value,
          ),
          const SizedBox(height: 8),

          // Forgot password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgotPassword');
              },
              child: Text(
                loc.forgotPassword,
                style: const TextStyle(
                  color: Color(0xFF6155F5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),

          // Login Button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: authVm.isLoading
                  ? null
                  : () async {
                      if (_globalKey.currentState!.validate()) {
                        final errorMessage = await authVm.login(
                          email!,
                          password!,
                        );
                        if (errorMessage == null && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(loc.loginSuccess),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                  errorMessage ?? loc.loginFailed),
                            ),
                          );
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6155F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: authVm.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      loc.loginButton,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
