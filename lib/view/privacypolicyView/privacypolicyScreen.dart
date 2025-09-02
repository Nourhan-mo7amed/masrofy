import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We value your privacy and want you to feel safe while using our app.",
                style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                "What We Collect",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                "• Basic information you provide such as expenses, notes, and uploaded receipts.\n"
                "• Optional account details like email (if you sign up).\n"
                "• No sensitive banking or card details are collected.",
                style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                "How We Use Data",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                "• To help you record and organize your daily expenses.\n"
                "• To create reports and charts that show your spending.\n"
                "• To let you save receipts and link them to your records.\n"
                "• To sync your data across devices (if you use cloud backup - Firebase).",
                style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                "Storage & Security",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                "• Your data is saved on your device (offline mode).\n"
                "• If you enable cloud sync, data is stored securely on Firebase servers.\n"
                "• We take reasonable steps to protect your information from unauthorized access.",
                style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                "Data Sharing",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                "We do not sell or share your personal data with third parties. "
                "Data may only be shared if required by law.",
                style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
