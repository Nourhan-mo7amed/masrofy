import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/constants/colors_app.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/models/transaction_model.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/tapButtom.dart';
import '../../viewmodels/transaction_viewModel.dart';

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

    final txViewModel = Provider.of<TransactionViewmodel>(context);

    // 🟢 Mapping categories & sources
    final categoryIcons = {
      "food": Icons.fastfood,
      "shopping": Icons.shopping_bag,
      "transport": Icons.directions_car,
      "rent": Icons.home,
    };
    final sourceIcons = {
      "salary": Icons.work,
      "freelance": Icons.laptop_mac,
      "gift": Icons.card_giftcard,
      "investment": Icons.trending_up,
    };

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
      backgroundColor: Colors.white,
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
                      isSelected: selectedTab == 0,
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
                      isSelected: selectedTab == 1,
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

            Expanded(
              child: StreamBuilder<List<TransactionModel>>(
                stream: selectedTab
                    ? txViewModel.incomesStream
                    : txViewModel.expensesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No transactions found"));
                  }
                  final filteredTransactions = snapshot.data!;

                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final tx = filteredTransactions[index];
                      final isExpense = tx.type == "expense";
                      final formattedDate = DateFormat(
                        'dd/MM/yyyy',
                      ).format(tx.date);
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 3,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: isExpense
                                ? AppColors.expense.withOpacity(0.1)
                                : AppColors.income.withOpacity(0.1),
                            child: Icon(
                              isExpense
                                  ? categoryIcons[tx.categoryId] ??
                                        Icons.category
                                  : sourceIcons[tx.source] ??
                                        Icons.attach_money,
                              color: isExpense
                                  ? AppColors.expense
                                  : AppColors.income,
                            ),
                          ),
                          title: Text(
                            tx.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            formattedDate,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Text(
                            "${isExpense ? '-' : '+'}${tx.amount.toStringAsFixed(2)} EGP",
                            style: TextStyle(
                              color: isExpense
                                  ? AppColors.expense
                                  : AppColors.income,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
