import 'package:flutter/material.dart';
import 'package:masrofy/view/homeView/widgets/Custom_singleChild_scroll_home.dart';

import '../../view/statisticsView/StatisticsScreen.dart';
import '../../view/addView/addScreen.dart';
import 'package:provider/provider.dart';
import '../../view/allTransactionView/all_transactionScreen.dart';
import '../../view/profileView/profileScreen.dart';
import '../../view/chatbotView/chatbotScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  // Remove this line; access providers inside build or state methods where context is available.
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomePage() {
    return CustomSingleChildScrollViewHome(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomePage(), // بيتبني كل مرة
      const StatisticsScreen(),
      const AddScreen(),
      const AlltransactionScreen(),
      const Profilescreen(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: AppBar(automaticallyImplyLeading: false),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).iconTheme.color,
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
