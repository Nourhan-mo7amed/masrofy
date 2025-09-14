import 'package:flutter/material.dart';
import '../../widgets/profilecard.dart';
import '../../widgets/LogoutDialog.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return LogoutDialog(
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          title: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ),
      ),
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
                  text: "Edit Profile",
                  color: Colors.purple,
                  onTap: () {
                    Navigator.pushNamed(context, '/editprofile');
                  },
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
                  icon: Icons.help_outline_outlined,
                  text: "Help",
                  color: Color.fromARGB(255, 33, 130, 240),
                  onTap: () {
                    Navigator.pushNamed(context, '/help');
                  },
                ),

                const SizedBox(height: 10),
                ProfileCard(
                  icon: Icons.logout,
                  text: "Logout",
                  color: Color(0xFFFF0000),
                  onTap: () => _showLogoutDialog(context),
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
