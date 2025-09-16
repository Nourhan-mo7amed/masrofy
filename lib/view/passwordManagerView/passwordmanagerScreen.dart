import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../widgets/PasswordField.dart';

class PasswordManager extends StatefulWidget {
  const PasswordManager({super.key});

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

  final _auth = FirebaseAuth.instance;
  bool _loading = false;

  void _changePassword() async {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final loc = AppLocalizations.of(context)!;

    if (newPassword != confirmPassword) {
      _showMessage(loc.passwordsDoNotMatch);
      return;
    }

    if (_auth.currentUser == null) {
      _showMessage(loc.noUserLoggedIn);
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      // إعادة المصادقة
      final user = _auth.currentUser!;
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(cred);

      // تغيير الباسورد
      await user.updatePassword(newPassword);
      _showMessage(loc.passwordChangedSuccessfully);
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        _showMessage(loc.incorrectCurrentPassword);
      } else if (e.code == 'weak-password') {
        _showMessage(loc.weakPassword);
      } else {
        _showMessage("${loc.error}: ${e.message}");
      }
    } catch (e) {
      _showMessage("${loc.error}: $e");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.passwordManager,
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PasswordField(
              label: loc.currentPassword,
              controller: currentPasswordController,
              obscureText: _obscureCurrent,
              onToggle: () => setState(() => _obscureCurrent = !_obscureCurrent),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // إضافة منطق استعادة الباسورد إذا أردت
                },
                child: Text(
                  loc.forgotPassword,
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(height: 10),
            PasswordField(
              label: loc.newPassword,
              controller: newPasswordController,
              obscureText: _obscureNew,
              onToggle: () => setState(() => _obscureNew = !_obscureNew),
            ),
            const SizedBox(height: 10),
            PasswordField(
              label: loc.confirmPassword,
              controller: confirmPasswordController,
              obscureText: _obscureConfirm,
              onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        loc.changePassword,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
