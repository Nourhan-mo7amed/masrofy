import 'package:flutter/material.dart';
import '../../widgets/profilecard.dart';
import '../../widgets/LogoutBottomSheet.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LogoutBottomSheet(
          onConfirm: () {
            Navigator.pushNamed(context, '/login');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: const [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/6eca1b5bc.png"),
                    radius: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Ahmed Hamdy",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "ahmed.hamdy@gmail.com",
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
