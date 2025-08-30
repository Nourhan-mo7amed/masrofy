import 'package:flutter/material.dart';
import '../../widgets/profilecard.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(
              child: Column(
                children: [
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
            SizedBox(height: 20),
            Column(
              children: [
                ProfileCard(
                  icon: Icons.account_circle,
                  text: "Account Info",
                  color: Colors.purple,
                ),
                SizedBox(height: 10),
                ProfileCard(
                  icon: Icons.privacy_tip_outlined,
                  text: "Privacy Policy",
                  color: Colors.green,
                ),
                SizedBox(height: 10),
                ProfileCard(
                  icon: Icons.lock_outline,
                  text: "Security Code",
                  color: Colors.blue,
                ),
                SizedBox(height: 10),
                ProfileCard(
                  icon: Icons.settings,
                  text: "Settings",
                  color: Colors.orange,
                ),
                SizedBox(height: 10),
                ProfileCard(
                  icon: Icons.logout,
                  text: "Logout",
                  color: Colors.red,
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
