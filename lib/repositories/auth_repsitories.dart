import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        return UserModel(name: name, email: email, uid: firebaseUser.uid);
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

        if (userDoc.exists) {
          return UserModel(
              name: userDoc['name'],
              email: userDoc['email'],
              uid: firebaseUser.uid);
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

  // 🟢 Forgot Password
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      print("✅ Password reset email sent to $email");
    } on FirebaseAuthException catch (e) {
      print("❌ FirebaseAuth Error in resetPassword: ${e.message}");
    } catch (e) {
      print("❌ Unknown Error in resetPassword: $e");
    }
  }

  // 🔴 Logout
  Future<void> signOut() async {
  try {
    // تسجيل خروج من Firebase
    await _firebaseAuth.signOut();

    // تسجيل خروج من Google
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    print("✅ User signed out from Firebase & Google");
  } catch (e) {
    print("❌ Error in signOut: $e");
  }
}
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // 1. تسجيل الدخول من جوجل
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // 2. جلب بيانات المصادقة
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. إنشاء credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. تسجيل الدخول في Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        final uid = user.uid;
        final email = user.email ?? "";
        final username = email.contains("@") ? email.split("@")[0] : email;

        final userDoc = _firestore.collection("users").doc(uid);
        final snapshot = await userDoc.get();

        if (!snapshot.exists) {
          // أول مرة يدخل بحساب جوجل → نحفظ بياناته
          await userDoc.set({
            "uid": uid,
            "name": user.displayName ?? username,
            "email": email,
            "username": username,
            "photoURL": user.photoURL,
            "createdAt": FieldValue.serverTimestamp(),
          });
          print("✅ User added to Firestore with Google Sign-In");
        } else {
          // لو موجود ممكن نعمل update لو حابب
          await userDoc.update({
            "lastLogin": FieldValue.serverTimestamp(),
          });
        }
      }

      return user;
    } catch (e) {
      print('❌ Error in Google Sign-In: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}

