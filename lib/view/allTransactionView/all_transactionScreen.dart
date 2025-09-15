import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/view/allTransactionView/widgets/custom_expeneses_listView.dart';
import 'package:masrofy/view/allTransactionView/widgets/custom_income_listView.dart';
import '../../widgets/tapButtom.dart';

class AlltransactionScreen extends StatefulWidget {
  const AlltransactionScreen({super.key});
  @override
  _AlltransactionScreen createState() => _AlltransactionScreen();
}
class _AlltransactionScreen extends State<AlltransactionScreen> {
  bool selectedTab = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          title: Text(
            loc.allTransactions,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ),
      ),
  //    backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TabButton(
                      text: loc.expenses,
                      isSelected: selectedTab == false,
                      onTap: () {
                        setState(() {
                          selectedTab = false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TabButton(
                      text: loc.income,
                      isSelected: selectedTab == true,
                      onTap: () {
                        setState(() {
                          selectedTab = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🟢 هنا بقى التبديل بين الويدجت
            Expanded(
              child: selectedTab
                  ? const CustomExpandedIncome()
                  : const CustomExpandedExpenses(),
            ),
          ],
        ),
      ),
    );
  }
}



