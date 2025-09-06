import 'package:flutter/material.dart';
import '../../widgets/tabbuttonhelp.dart';
import '../../widgets/FAQTab.dart';
import '../../widgets/ContactTab.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help Center",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TabButtonhelp(
                      text: "FAQ",
                      isSelected: selectedTab == 0,
                      onTap: () {
                        setState(() {
                          selectedTab = 0;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TabButtonhelp(
                      text: "Contact Us",
                      isSelected: selectedTab == 1,
                      onTap: () {
                        setState(() {
                          selectedTab = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(child: selectedTab == 0 ? FAQTab() : ContactTab()),
          ],
        ),
      ),
    );
  }
}
