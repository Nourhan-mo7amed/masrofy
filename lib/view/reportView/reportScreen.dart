import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ReportScreen extends StatelessWidget {
  final List<ChatMessage> answers;

  const ReportScreen({super.key, required this.answers});

  @override
  Widget build(BuildContext context) {
    final spending = _getUserAnswer(0);
    final biggestExpense = _getUserAnswer(1);
    final goal = _getUserAnswer(2);

    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Report",style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Here’s your financial overview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "This month you spent $spending EGP.\n"
              "Your biggest expense is $biggestExpense.\n"
              "Your financial goal: $goal.",
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 16),

            Text(
              "Key Insights",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            Text(
              "• Your $biggestExpense spending increased compared to last month.",
            ),
            Text("• $biggestExpense is your largest category."),
            Text("• Transportation costs stayed stable."),
            Text("• You are close to exceeding your budget in Shopping."),
            SizedBox(height: 20),

            Text(
              "Smart Suggestions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("• Set a weekly spending limit for $biggestExpense."),
            Text("• Try meal prepping to cut down food costs."),
            Text("• Save money for your goal: $goal."),
            Text("• Review subscriptions and cancel unused ones."),
          ],
        ),
      ),
    );
  }
  
  String _getUserAnswer(int questionIndex) {
    final userAnswers = answers
        .where((msg) => msg.user.firstName == "You")
        .toList();
    userAnswers.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    if (questionIndex < userAnswers.length) {
      return userAnswers[questionIndex].text;
    }
    return "Not provided";
  }
}
