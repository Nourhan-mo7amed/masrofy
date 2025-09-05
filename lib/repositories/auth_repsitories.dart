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
      // إنشاء المستخدم في Firebase Authentication
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        print("🔥 Firebase User UID: ${firebaseUser.uid}");
        print("🔥 Adding to Firestore...");

        // حفظ البيانات في Firestore
        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'uid': firebaseUser.uid,
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        print("✅ Added to Firestore");
        return UserModel(name: name, email: email);
      }
    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuth Error in signUp: ${e.message}');
    } on FirebaseException catch (e) {
      print('❌ Firestore Error in signUp: ${e.message}');
    } catch (e) {
      print('❌ Unknown Error in signUp: $e');
    }
    return null;
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      // تسجيل الدخول

      print(email);
      print(password);
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // جلب بيانات المستخدم من Firestore
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .get();
            print("wellllllllllllll hooooooooooooooooo😍😎😎😋😍😎");

        if (userDoc.exists) {
          return UserModel(name: userDoc['name'], email: userDoc['email']);
        } else {
          print("⚠️ User document does not exist in Firestore.");
        }
      }
    } on FirebaseAuthException catch (e) {
      print(" emaaaaail $email");
      print("passssssword  $password");

      print('❌ FirebaseAuth Error in login: ${e.message}');
    } on FirebaseException catch (e) {
      print('❌ Firestore Error in login: ${e.message}');
    } catch (e) {
      print('❌ Unknown Error in login: $e');
    }
    return null;
  }
}
