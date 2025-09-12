import 'package:flutter/material.dart';
import 'package:masrofy/repositories/auth_repsitories.dart';
import 'package:masrofy/viewmodels/Auth_ViewModel.dart';
import 'package:provider/provider.dart';
import '../../widgets/profilecard.dart';
import '../../widgets/LogoutBottomSheet.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  void initState() {
    super.initState();
    // Load user once when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authVM = Provider.of<AuthViewModel>(context, listen: false);
      authVM.loadCurrentUser();
    });
  }

  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LogoutBottomSheet(
          onConfirm: () async {
            final authVM = Provider.of<AuthViewModel>(context, listen: false);
            await AuthRepository().signOut();
            await authVM.logout();
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
    return Scaffold(
      body: Consumer<AuthViewModel>(
        builder: (context, authVM, child) {
          if (authVM.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = authVM.currentUser;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : const AssetImage("assets/images/gest.png")
                                as ImageProvider,
                        radius: 50,
                      ),
                      const SizedBox(height: 10),
                      if (user != null) ...[
                        Text(
                          user.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          user.email,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ] else ...[
                        const Text(
                          "Guest User",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ProfileCard(
                      icon: Icons.account_circle,
                      text: "Account Info",
                      color: Colors.purple,
                    ),
                    const SizedBox(height: 10),
                    ProfileCard(
                      icon: Icons.privacy_tip_outlined,
                      text: "Privacy Policy",
                      color: Colors.green,
                      onTap: () {
                        Navigator.pushNamed(context, '/privacypolicy');
                      },
                    ),
                    const SizedBox(height: 10),
                    ProfileCard(
                      icon: Icons.settings,
                      text: "Settings",
                      color: const Color(0xFFB55E00),
                      onTap: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                    const SizedBox(height: 10),
                    ProfileCard(
                      icon: Icons.logout,
                      text: "Logout",
                      color: const Color(0xFFFF0000),
                      onTap: () => _showLogoutSheet(context),
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
