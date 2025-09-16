import 'package:flutter/material.dart';
import 'package:dash_chat_3/dash_chat_3.dart';

class ReportScreen extends StatelessWidget {
  final List<ChatMessage> answers;

  const ReportScreen({super.key, required this.answers});

  String _getUserAnswer(int index) {
    final userAnswers = answers
        .where((msg) => msg.user.firstName == "You")
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return index < userAnswers.length ? userAnswers[index].text : "Not provided";
  }

  String generateSmartReport() {
    final spendingStr = _getUserAnswer(0);
    final biggestExpense = _getUserAnswer(1).toLowerCase();
    final goal = _getUserAnswer(2);

    // حاول تحويل المصاريف لرقم
    double? spending = double.tryParse(spendingStr.replaceAll(RegExp(r'[^0-9.]'), ''));
    
    // نصائح ذكية حسب الحالة
    List<String> insights = [];
    List<String> suggestions = [];

    if (spending != null) {
      if (spending < 2000) {
        insights.add("Your spending is quite low, you might want to consider increasing your income.");
        suggestions.add("Look for extra income sources or side projects.");
        suggestions.add("Keep tracking expenses to stay on top of your finances.");
      } else if (spending >= 2000 && spending <= 5000) {
        insights.add("Your spending is moderate, good job managing it.");
        suggestions.add("Keep tracking expenses and try saving a portion of your income.");
      } else {
        insights.add("Your spending is high, you should optimize your expenses.");
        suggestions.add("Use public transport instead of taxis or ride-hailing apps.");
        suggestions.add("Review subscriptions and unnecessary purchases.");
      }
    } else {
      insights.add("Unable to analyze spending due to invalid input.");
    }

    // نصائح عامة حسب أكبر مصروف
    if (biggestExpense.contains("food") || biggestExpense.contains("restaurants")) {
      suggestions.add("Try meal prepping or cooking at home to save money.");
    } else if (biggestExpense.contains("transport")) {
      suggestions.add("Consider using metro or bus instead of ride-hailing apps.");
    } else if (biggestExpense.contains("shopping")) {
      suggestions.add("Avoid impulse purchases and create a shopping budget.");
    }

    // التقرير النهائي
    return """
📊 Financial Overview:
- Your average monthly spending: $spendingStr
- Biggest expense: $biggestExpense
- Financial goal: $goal

💡 Key Insights:
${insights.map((i) => "- $i").join("\n")}

📝 Smart Suggestions:
${suggestions.map((s) => "- $s").join("\n")}
""";
  }

  @override
  Widget build(BuildContext context) {
    final report = generateSmartReport();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Financial Report"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            report,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
