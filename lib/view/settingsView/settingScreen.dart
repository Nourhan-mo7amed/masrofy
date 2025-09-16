import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/viewmodels/settings_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../widgets/SettingsSwitchTile.dart';
import '../../widgets/SettingsTile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final viewModel = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settings),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SettingsTile(
            icon: Icons.person_outline,
            text: loc.account, // 👈 الحساب
            onTap: () {},
          ),

          SettingsSwitchTile(
            icon: Icons.notifications_none_outlined,
            text: loc.notifications, // 👈 الإشعارات
            value: notifications,
            onChanged: (val) {
              setState(() => notifications = val);
            },
          ),

          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: Text(loc.darkMode), // 👈 الوضع المظلم
            value: viewModel.settings.darkMode,
            onChanged: (val) {
              viewModel.toggleDarkMode(val);
            },
          ),
          SizedBox(height: 5),

          SwitchListTile(
            secondary: const Icon(Icons.language_outlined),
            title: Text(loc.language), // 👈 اللغة
            subtitle: Text(
              selectedLanguage == "English" ? loc.english : loc.arabic,
            ),
            value: selectedLanguage == "English",
            onChanged: (val) {
              setState(() {
                selectedLanguage = val ? "English" : "Arabic";
              });
              viewModel.changeLanguage(selectedLanguage);
            },
          ),

          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              loc.supportTitle, // 👈 الدعم
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
