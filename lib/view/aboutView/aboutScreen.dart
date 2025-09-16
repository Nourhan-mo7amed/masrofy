import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../widgets/AboutItem.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.aboutUs,
          style: TextStyle( fontWeight: FontWeight.bold),
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
              loc.appName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              loc.aboutDescription,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            AboutItem(
              icon: Icons.account_balance_wallet,
              text: loc.trackExpenses,
            ),
            AboutItem(icon: Icons.bar_chart, text: loc.manageBudget),
            AboutItem(icon: Icons.show_chart, text: loc.viewReports),
            AboutItem(icon: Icons.notifications, text: loc.smartReminders),
            AboutItem(icon: Icons.public, text: loc.multiCurrencySupport),
            SizedBox(height: 20),
            Text(
              loc.ourMission,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              loc.aboutMission,
              style: TextStyle(height: 1.5, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Text(
              loc.version,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Developed By: [GDG Group 6]",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
