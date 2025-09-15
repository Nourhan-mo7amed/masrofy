import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/viewmodels/transaction_viewModel.dart';
import 'package:provider/provider.dart';
import '../../widgets/shopping_expenseitem.dart';
 // 👈 import loc

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final loc = AppLocalizations.of(context)!;
    if (uid == null) {
      return Scaffold(
        body: Center(
          child: Text(loc.userNotLoggedIn), // 👈 باستخدام loc
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.shopping, // 👈 باستخدام loc
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<TransactionViewmodel>(
          builder: (context, value, child) {
            return StreamBuilder(
              stream: value.getExpensesByCategory("shopping"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      loc.noShoppingTransactions, // 👈 باستخدام loc
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

                    return ShoppingExpenseitem(
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
