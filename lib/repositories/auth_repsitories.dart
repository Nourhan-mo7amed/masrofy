import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masrofy/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        UserModel userModel = UserModel(
          id: firebaseUser.uid,
          name: name,
          email: email,
          password: password,
        );

        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'id': userModel.id,
          'name': userModel.name,
          'email': userModel.email,
          'password': userModel.password,
        });

        return userModel;
      }
    } catch (e) {
      print('Error in signUp: $e');
    }
    return null;
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .get();

        if (userDoc.exists) {
          return UserModel(
            id: firebaseUser.uid,
            name: userDoc['name'],
            email: userDoc['email'],
            password: userDoc['password'],
          );
        }
      }
    } catch (e) {
      print('Error in login: $e');
    }
    return null;
  }
}
