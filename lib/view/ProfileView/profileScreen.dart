import 'package:flutter/material.dart';
import 'package:masrofy/repositories/auth_repsitories.dart';
import 'package:masrofy/viewmodels/Auth_ViewModel.dart';
import 'package:provider/provider.dart';
import '../../widgets/profilecard.dart';
import '../../widgets/LogoutBottomSheet.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LogoutBottomSheet(
          onConfirm: () async {
            // 🟢 استدعاء تسجيل الخروج
            await AuthRepository().signOut();

            // 🔴 بعد ما يسجل خروج يروح للـ Login
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false, // يشيل كل الصفحات اللي قبله من الـ stack
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/6eca1b5bc.png"),
                    radius: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${authVM.currentUser!.name}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                   Text(
                    "${authVM.currentUser!.email}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                ProfileCard(
                  icon: Icons.account_circle,
                  text: "Account Info",
                  color: Colors.purple,
                ),
                const SizedBox(height: 10),

                ProfileCard(
                  icon: Icons.privacy_tip_outlined,
                  text: "Privacy Policy",
                  color: Colors.green,
                  onTap: () {
                    Navigator.pushNamed(context, '/privacypolicy');
                  },
                ),

                const SizedBox(height: 10),
                ProfileCard(
                  icon: Icons.settings,
                  text: "Settings",
                  color: Color(0xFFB55E00),
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),

                const SizedBox(height: 10),
                ProfileCard(
                  icon: Icons.logout,
                  text: "Logout",
                  color: Color(0xFFFF0000),
                  onTap: () => _showLogoutSheet(context),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
