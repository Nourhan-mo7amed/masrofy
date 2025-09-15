import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/viewmodels/transaction_viewModel.dart';
import 'package:provider/provider.dart';
import '../../widgets/bills_ExpenseItem.dart';

class Billsscreen extends StatelessWidget {
  const Billsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text(loc.userNotLoggedIn), // 🟢 لوكالايزيشن هنا
        ),
      );
    }
    final String uid = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.bills, // 🟢 Bills باللوكالايزيشن
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<TransactionViewmodel>(
          builder: (context, value, child) {
            return StreamBuilder(
              stream: value.getExpensesByCategory("bills"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      loc.noBillsTransactions, // 🟢 رساله عدم وجود معاملات
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                final transactions = snapshot.data!;

                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tx = transactions[index];

                    return BillsExpenseitem(
                      title: tx.title,
                      date: "${tx.date.day}-${tx.date.month}-${tx.date.year}",
                      amount:
                          "${tx.type == "income" ? "+" : "-"} \$${tx.amount.toStringAsFixed(2)}",
                      color: tx.type == "income" ? Colors.green : Colors.red,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
