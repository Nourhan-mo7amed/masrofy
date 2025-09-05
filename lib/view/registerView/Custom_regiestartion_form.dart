import 'package:flutter/material.dart';
import 'package:masrofy/viewmodels/Auth_ViewModel.dart';
import 'package:masrofy/widgets/Costom_TextFormField.dart';
import 'package:provider/provider.dart';

class CustomRegistrationForm extends StatefulWidget {
  const CustomRegistrationForm({super.key});

  @override
  State<CustomRegistrationForm> createState() => _CustomRegistrationFormState();
}

class _CustomRegistrationFormState extends State<CustomRegistrationForm> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? name, email, password;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();

    return Form(
      key: _globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full Name
          const Text(
            'Full Name',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            hintText: 'Full Name',
            icon: Icons.person_outline,
            controller: nameController,
            onChanged: (value) {
              name = value;
            },
          ),
          const SizedBox(height: 16),

          // Email
          const Text(
            'Email',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            hintText: 'Email',
            icon: Icons.email_outlined,
            controller: emailController,
            onChanged: (value) {
              email = value;
            },
          ),
          const SizedBox(height: 16),

          // Password
          const Text(
            'Password',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            hintText: 'Password',
            icon: Icons.lock_outline,
            isPassword: true,
            controller: passwordController,
            onChanged: (value) {
              password = value;
            },
          ),
          const SizedBox(height: 16),

          // Confirm Password
          const Text(
            'Confirm Password',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            hintText: 'Confirm Password',
            icon: Icons.lock_outline,
            isPassword: true,
            controller: confirmPasswordController,
          ),

          const SizedBox(height: 35),

          // Register Button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: authVm.isLoading
                  ? null
                  : () async {
                      if (_globalKey.currentState!.validate()) {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          print("✅ Registered Successfully");
                          print("Name: ${nameController.text}");
                          print("Email: ${emailController.text}");
                          final errorMessage = await authVm.signUp(
                            name!,
                            email!,
                            password!,
                          );

                          if (errorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Registration successful"),
                              ),
                            );
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match"),
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
                  : const Text(
                      "Sign Up",
                      style: TextStyle(
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
