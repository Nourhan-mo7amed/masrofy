import 'package:flutter/material.dart';
import '../../widgets/SettingsSwitchTile.dart';
import '../../widgets/SettingsTile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
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
          SettingsTile(icon: Icons.person, text: "Account", onTap: () {}),
          SettingsSwitchTile(
            icon: Icons.notifications,
            text: "Notifications",
            value: notifications,
            onChanged: (val) {
              setState(() => notifications = val);
            },
          ),

          SettingsSwitchTile(
            icon: Icons.brightness_6,
            text: "Mode",
            value: mode,
            onChanged: (val) {
              setState(() => mode = val);
            },
          ),

          ListTile(
            leading: Icon(Icons.language_outlined, color: Colors.black),
            title: Text("Language"),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: ["English", "Arabic"].map((lang) {
                return DropdownMenuItem<String>(value: lang, child: Text(lang));
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => selectedLanguage = val);
                }
              },
            ),
          ),

          SizedBox(height: 32),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Support",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          SettingsTile(text: "Support", onTap: () {}),
          SettingsTile(text: "Help", onTap: () {}),
          SettingsTile(text: "FAQ", onTap: () {}),
        ],
      ),
    );
  }
}
