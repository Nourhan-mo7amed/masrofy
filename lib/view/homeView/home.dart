import 'package:flutter/material.dart';
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

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomePage(),
      StatisticsScreen(),
      AddScreen(),
      AlltransactionScreen(),
      Profilescreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.list, size: 30)),
                SizedBox(width: 90),
                Center(
                  child: Text(
                    "Home",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 160,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
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
                          "Total Balance ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                    Icon(Icons.more_horiz, color: Colors.white),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "\$ 3,350.00",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_up_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Income \n\$ 2,250.00",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_down_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Expenses\n\$ 1,300.00",
                          style: TextStyle(
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
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              "Expense",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/shopping');
            },
            child: ExpenseItem(
              icon: Icons.shopping_bag_outlined,
              color: Colors.orange,
              title: "Shopping",
              amount: "- 300.49",
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/subscriptions');
            },
            child: ExpenseItem(
              icon: Icons.subscriptions_outlined,
              color: Colors.pink,
              title: "Subscriptions",
              amount: "- 300.49",
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/food');
            },
            child: ExpenseItem(
              icon: Icons.fastfood_outlined,
              color: Colors.purple,
              title: "Food",
              amount: "- 300.49",
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/another');
            },
            child: ExpenseItem(
              icon: Icons.widgets_outlined,
              color: Colors.blue,
              title: "Another",
              amount: "- 300.49",
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: AppBar(automaticallyImplyLeading: false),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF6155F5),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
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
