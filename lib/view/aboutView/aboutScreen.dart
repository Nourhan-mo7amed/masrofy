import 'package:flutter/material.dart';
import '../../widgets/AboutItem.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Masrofy",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Masrofy is a personal finance management app designed to help you stay in control of your money.\n"
              "With Masrofy, You Can :",
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            AboutItem(
              icon: Icons.account_balance_wallet,
              text: "Track your daily expenses easily and quickly.",
            ),
            AboutItem(
              icon: Icons.bar_chart,
              text:
                  "Set and manage your monthly budget to reach your financial goals.",
            ),
            AboutItem(
              icon: Icons.show_chart,
              text:
                  "View detailed reports and charts to understand your spending habits.",
            ),
            AboutItem(
              icon: Icons.notifications,
              text: "Get smart reminders to stay on track with your expenses.",
            ),
            AboutItem(
              icon: Icons.public,
              text:
                  "Support for multiple currencies (EGP, USD, EUR, and more).",
            ),
            SizedBox(height: 20),
            Text(
              "Our Mission :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              "To make money management simple, clear, and stress-free for everyone.",
              style: TextStyle(height: 1.5, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Text(
              "Version: 1.0.0",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Developed By: [Your Name / Your Team]",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
