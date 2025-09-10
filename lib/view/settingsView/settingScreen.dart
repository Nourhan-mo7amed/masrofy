import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:masrofy/viewmodels/settings_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../widgets/SettingsSwitchTile.dart';
import '../../widgets/SettingsTile.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final loc = AppLocalizations.of(context)!;
    final viewModel = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settings),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          SettingsTile(icon: Icons.person, text: loc.account, onTap: () {}),

          SettingsSwitchTile(
            icon: Icons.notifications,
            text: loc.notifications,
            value: notifications,
            onChanged: (val) {
              setState(() => notifications = val);
            },
          ),

          SwitchListTile(
            title: const Text("Dark Mode"),
            value: viewModel.settings.darkMode,
            onChanged: viewModel.toggleDarkMode,
          ),

          ListTile(
            leading: const Icon(Icons.language_outlined, color: Colors.black),
            title: Text(loc.language),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: [loc.english, loc.arabic].map((lang) {
                return DropdownMenuItem<String>(value: lang, child: Text(lang));
              }).toList(),
              onChanged: (val) {
                if (val != null) viewModel.changeLanguage(val);
              },
            ),
          ),

          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              loc.supportTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          SettingsTile(text: loc.support, onTap: () {}),
          SettingsTile(text: loc.help, onTap: () {}),
          SettingsTile(text: loc.faq, onTap: () {}),
        ],
      ),
    );
  }
}
