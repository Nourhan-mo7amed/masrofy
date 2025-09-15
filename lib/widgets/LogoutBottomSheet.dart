import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';

class LogoutBottomSheet extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutBottomSheet({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                loc.logout, // "تسجيل الخروج" أو "Logout"
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6155F5),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                loc.logoutConfirmation, // "هل أنت متأكد أنك تريد تسجيل الخروج؟"
                style: const TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(loc.cancel), // "إلغاء" أو "Cancel"
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6155F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(loc.confirmLogout), 
                      // "نعم، تسجيل الخروج" أو "Yes, Logout"
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
