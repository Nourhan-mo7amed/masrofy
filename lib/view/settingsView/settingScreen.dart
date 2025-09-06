import 'package:flutter/material.dart';
import '../../widgets/SettingsSwitchTile.dart';
import '../../widgets/SettingsTile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = false;
  bool mode = false;
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              "Account",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SettingsTile(
            avatar: AssetImage("assets/images/profile.jpg"),
            text: "joe_john",
            subtext: "joe_john 45@gmail.com",
            onTap: () {},
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[400],
            indent: 16,
            endIndent: 16,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              "Settings",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SettingsSwitchTile(
            icon: Icons.notifications,
            text: "Notifications",
            value: notifications,
            onChanged: (val) {
              setState(() => notifications = val);
            },
          ),
          SizedBox(height: 5),
          SettingsSwitchTile(
            icon: Icons.dark_mode_outlined,
            text: "Dark Mode",
            value: mode,
            onChanged: (val) {
              setState(() => mode = val);
            },
          ),
          SizedBox(height: 5),

          Card(
            elevation: 0,
            child: ListTile(
              leading: Icon(Icons.language_outlined, color: Colors.black),
              title: Text(
                "Language",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: DropdownButton<String>(
                value: selectedLanguage,
                items: ["English", "Arabic"].map((lang) {
                  return DropdownMenuItem<String>(
                    value: lang,
                    child: Text(
                      lang,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedLanguage = value);
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 5),
          SettingsTile(
            icon: Icons.key_sharp,
            text: "Password Manager",
            onTap: () {
              Navigator.pushNamed(context, '/passwordManager');
            },
          ),
          SizedBox(height: 5),
          SettingsTile(
            icon: Icons.feedback_outlined,
            text: "Feedback",
            onTap: () {
              Navigator.pushNamed(context, '/feedback');
            },
          ),
          SizedBox(height: 5),
          SettingsTile(
            icon: Icons.info_outline,
            text: "About us",
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }
}
