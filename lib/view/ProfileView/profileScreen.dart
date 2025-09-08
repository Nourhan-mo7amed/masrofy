import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../widgets/profilecard.dart';
import '../../widgets/LogoutBottomSheet.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LogoutBottomSheet(
          onConfirm: () {
            Navigator.pushNamed(context, '/login');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/6eca1b5bc.png"),
                    radius: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    loc.userName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    loc.userEmail,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                ProfileCard(
                  icon: Icons.account_circle,
                  text: loc.accountInfo,
                  color: Colors.purple,
                ),
                const SizedBox(height: 10),
                ProfileCard(
                  icon: Icons.privacy_tip_outlined,
                  text: loc.privacyPolicy,
                  color: Colors.green,
                  onTap: () {
                    Navigator.pushNamed(context, '/privacypolicy');
                  },
                ),
                const SizedBox(height: 10),
                ProfileCard(
                  icon: Icons.settings,
                  text: loc.settings,
                  color: const Color(0xFFB55E00),
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                const SizedBox(height: 10),
                ProfileCard(
                  icon: Icons.logout,
                  text: loc.logout,
                  color: const Color(0xFFFF0000),
                  onTap: () => _showLogoutSheet(context),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
