import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masrofy/models/user_model.dart';
import '../repositories/auth_repsitories.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 🟢 تحميل بيانات اليوزر الحالي (لو موجود في Firebase)
  Future<void> loadCurrentUser() async {
    _setLoading(true);
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        final snapshot =
            await _firestore.collection("users").doc(firebaseUser.uid).get();

        if (snapshot.exists) {
          _currentUser = UserModel.fromMap(snapshot.data()!);
        } else {
          _currentUser = null;
        }
      } else {
        _currentUser = null;
      }
    } catch (e) {
      _currentUser = null;
      print("Error loading user: $e");
    } finally {
      _setLoading(false);
    }
  }

  // 🟢 تسجيل الدخول Email/Password
  Future<String?> login(String email, String password) async {
    _setLoading(true);
    try {
      final user = await _authRepository.login(email: email, password: password);
      if (user == null) return "Email or password is incorrect";

      _currentUser = user;
      notifyListeners();
      return null;
    } catch (e) {
      print("Login error: $e");
      return "An error occurred during login";
    } finally {
      _setLoading(false);
    }
  }

  // 🟢 تسجيل حساب جديد Email/Password
  Future<String?> signUp(String name, String email, String password) async {
    _setLoading(true);
    try {
      final user = await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
      );
      if (user == null) return "Failed to create account";

      _currentUser = user;
      notifyListeners();
      return null;
    } catch (e) {
      print("SignUp error: $e");
      return "An error occurred during sign up";
    } finally {
      _setLoading(false);
    }
  }

  // 🟢 تسجيل خروج
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _authRepository.signOut();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      print("Logout error: $e");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
