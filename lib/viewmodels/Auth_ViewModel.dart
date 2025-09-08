import 'package:flutter/material.dart';
import 'package:masrofy/models/user_model.dart';
import '../repositories/auth_repsitories.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //login
  Future<String?> login(String email, String password) async {
    _setLoading(true);

    final user = await _authRepository.login(email: email, password: password);
    _setLoading(false);
    if (user == null) {
      return "Email or password is incorrect";
    }
    _currentUser = user;
    notifyListeners();
    return null;
  }

  // sign Up
  Future<String?> signUp(String name, String email, String password) async {
    _setLoading(true);
    final user = await _authRepository.signUp(
      name: name,
      email: email,
      password: password,
    );
    _setLoading(false);
    if (user == null) {
      return "Faild to create account";
    }

    _currentUser = user;
    notifyListeners();
    return null;
  }

  // Reset Password

  // String? resetPassword(String email) {
  //   try {
  //     final user = _users.firstWhere((u) => u.email == email);
  //     return "Password reset link sent to ${user.email}";
  //   } catch (e) {
  //     return "Email not found";
  //   }
  // }

  //Logout

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
