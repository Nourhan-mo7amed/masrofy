import 'package:flutter/material.dart';

class FAQTab extends StatelessWidget {
  const FAQTab({super.key});

  @override
  Widget build(BuildContext context) {
    final faqList = [
      {
        "question": "How can I add a new expense?",
        "answer":
            "From the home screen, tap the + button and enter the details (amount, category, date).",
      },
      {
        "question": "Can I edit or delete an expense?",
        "answer":
            "Yes, tap long press on the expense from the list to edit or delete it.",
      },
      {
        "question": "How do I set a monthly budget?",
        "answer":
            "Go to the 'Budget' tab and set the target amount for the month and categories you want to track.",
      },
      {
        "question": "Does the app provide reports or statistics?",
        "answer":
            "Yes, you can view charts and monthly reports to track your spending habits.",
      },
      {
        "question": "How can I change the currency or language?",
        "answer":
            "You can change currency (EGP, USD, EUR, etc.) and language from the settings menu.",
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: faqList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
              child: ExpansionTile(
                title: Text(
                  faqList[index]["question"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                iconColor: Color(0xFF6155F5),
                collapsedIconColor: Color(0xFF6155F5),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      faqList[index]["answer"]!,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }
}
