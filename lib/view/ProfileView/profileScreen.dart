import 'package:flutter/material.dart';
import 'package:masrofy/repositories/auth_repsitories.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masrofy/widgets/LogoutDialog.dart';
import '../../widgets/profilecard.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return LogoutDialog(
          onConfirm: () async {
            await AuthRepository().signOut();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("No user data found"));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: userData["photoURL"] != null
                            ? NetworkImage(userData["photoURL"])
                            : const AssetImage("assets/images/gest.png")
                                  as ImageProvider,
                        radius: 50,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userData["name"] ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userData["email"] ?? "",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "@${userData["username"] ?? ""}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
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
                      text: "Edit Profile",
                      color: Colors.purple,
                      onTap: () {
                        Navigator.pushNamed(context, '/editprofile');
                      },
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
                      icon: Icons.help_outline_outlined,
                      text: "Help",
                      color: Color.fromARGB(255, 33, 130, 240),
                      onTap: () {
                        Navigator.pushNamed(context, '/help');
                      },
                    ),
                    ProfileCard(
                      icon: Icons.logout,
                      text: loc.logout,
                      color: const Color(0xFFFF0000),
                      onTap: () => _showLogoutDialog(context),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
