import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';

class FAQTab extends StatelessWidget {
  const FAQTab({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final faqList = [
      {
        "question": loc.faqAddExpenseQuestion,
        "answer": loc.faqAddExpenseAnswer,
      },
      {
        "question": loc.faqEditDeleteQuestion,
        "answer": loc.faqEditDeleteAnswer,
      },
      {
        "question": loc.faqSetBudgetQuestion,
        "answer": loc.faqSetBudgetAnswer,
      },
      {
        "question": loc.faqReportsQuestion,
        "answer": loc.faqReportsAnswer,
      },
      {
        "question": loc.faqChangeCurrencyLanguageQuestion,
        "answer": loc.faqChangeCurrencyLanguageAnswer,
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
                iconColor: const Color(0xFF6155F5),
                collapsedIconColor: const Color(0xFF6155F5),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      faqList[index]["answer"]!,
                      style: const TextStyle(color: Colors.grey),
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
