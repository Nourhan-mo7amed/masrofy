import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/expenseItem.dart';
import '../../view/statisticsView/StatisticsScreen.dart';
import '../../view/addView/addScreen.dart';
import '../../view/allTransactionView/all_transactionScreen.dart';
import '../../view/profileView/profileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomePage(BuildContext context) {
    final t = AppLocalizations.of(context)!; // for translations

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.list, size: 30),
                const SizedBox(width: 90),
                Center(
                  child: Text(
                    t.homeTitle,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 160,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 52, 92, 224),
                  Color.fromARGB(255, 211, 74, 181),
                  Color.fromARGB(255, 245, 183, 51),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          t.totalBalance,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                      ],
                    ),
                    const Icon(Icons.more_horiz, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "\$ 3,350.00",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.arrow_circle_up_outlined, color: Colors.white, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          "${t.income}\n\$ 2,250.00",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.arrow_circle_down_outlined, color: Colors.white, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          "${t.expenses}\n\$ 1,300.00",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              t.expense,
              style: const TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/shopping'),
            child: ExpenseItem(
              icon: Icons.shopping_bag_outlined,
              color: Colors.orange,
              title: t.shopping,
              amount: "- 300.49",
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/subscriptions'),
            child: ExpenseItem(
              icon: Icons.subscriptions_outlined,
              color: Colors.pink,
              title: t.subscriptions,
              amount: "- 300.49",
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/food'),
            child: ExpenseItem(
              icon: Icons.fastfood_outlined,
              color: Colors.purple,
              title: t.food,
              amount: "- 300.49",
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/another'),
            child: ExpenseItem(
              icon: Icons.widgets_outlined,
              color: Colors.blue,
              title: t.another,
              amount: "- 300.49",
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build pages here so context is valid
    final pages = [
      _buildHomePage(context),
      const StatisticsScreen(),
      const AddScreen(),
      const AlltransactionScreen(),
      const Profilescreen(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: AppBar(automaticallyImplyLeading: false),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF6155F5),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, size: 30),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 40, color: Color(0xFF6155F5)),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet, size: 30),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 30),
            label: "",
          ),
        ],
      ),
    );
  }
}
