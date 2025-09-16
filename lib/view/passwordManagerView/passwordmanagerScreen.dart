import 'package:flutter/material.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../widgets/PasswordField.dart';

class PasswordManager extends StatefulWidget {
  @override
  State<PasswordManager> createState() => _PasswordManagerState();
}

class _PasswordManagerState extends State<PasswordManager> {
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.passwordManager,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PasswordField(
              label: loc.currentPassword,
              controller: currentPasswordController,
              obscureText: _obscureCurrent,
              onToggle: () {
                setState(() {
                  _obscureCurrent = !_obscureCurrent;
                });
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  loc.forgotPassword,
                  style: TextStyle(color: Color(0xFF6155F5)),
                ),
              ),
            ),
            SizedBox(height: 10),
            PasswordField(
              label: loc.newPassword,
              controller: newPasswordController,
              obscureText: _obscureNew,
              onToggle: () {
                setState(() {
                  _obscureNew = !_obscureNew;
                });
              },
            ),
            SizedBox(height: 20),
            PasswordField(
              label: loc.confirmPassword,
              controller: confirmPasswordController,
              obscureText: _obscureConfirm,
              onToggle: () {
                setState(() {
                  _obscureConfirm = !_obscureConfirm;
                });
              },
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6155F5),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  loc.changePassword,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
