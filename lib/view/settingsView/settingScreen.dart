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
            onTap: () {
               Navigator.pushNamed(context, '/editprofile');
            },
          ),
          Divider(thickness: 1),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              loc.settings, // 👈 ترجمها من الـ l10n
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          SettingsSwitchTile(
            icon: Icons.notifications_none_outlined,
            text: loc.notifications, // 👈 الإشعارات
            value: notifications,
            onChanged: (val) {
              setState(() => notifications = val);
            },
          ),
          SizedBox(height: 5),
          SettingsSwitchTile(
            icon: Icons.dark_mode_outlined,
            text: loc.darkMode, // 👈 الإشعارات
            value: viewModel.settings.darkMode,
            onChanged: (val) {
              viewModel.toggleDarkMode(val);
            },
          ),
          // SwitchListTile(
          //   secondary: const Icon(Icons.dark_mode_outlined),
          //   title: Text(loc.darkMode), // 👈 الوضع المظلم
          //   value: viewModel.settings.darkMode,
          //   onChanged: (val) {
          //     viewModel.toggleDarkMode(val);
          //   },
          // ),
          SizedBox(height: 5),

          Card(
            elevation: 0,
            child: SwitchListTile(
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
          ),

          const SizedBox(height: 32),
          SizedBox(height: 5),
          SettingsTile(
            icon: Icons.key_sharp,
            text: loc.passwordManager, // 👈 مدير كلمات المرور
            onTap: () {
              Navigator.pushNamed(context, '/passwordManager');
            },
          ),
          SizedBox(height: 5),
          SettingsTile(
            icon: Icons.feedback_outlined,
            text: loc.feedback, // 👈 الملاحظات",
            onTap: () {
              Navigator.pushNamed(context, '/feedback');
            },
          ),
          SizedBox(height: 5),
          SettingsTile(
            icon: Icons.info_outline,
            text: loc.aboutUs, // 👈 حول التطبي ق
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }
}
