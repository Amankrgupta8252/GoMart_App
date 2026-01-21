import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // REGISTER
  static Future<bool> register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await _db.collection('users').doc(result.user!.uid).set({
      //   'email': email,
      //   'uid': result.user!.uid,
      //   'createdAt': FieldValue.serverTimestamp(),
      // });

      return true;
    } catch (e) {
      print("REGISTER ERROR: $e");
      return false;
    }
  }

  // LOGIN
  static Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return false;
    }

  }

  // LOGOUT
  static Future<void> logout() async {
    await _auth.signOut();
  }
}
