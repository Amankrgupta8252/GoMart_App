import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'services/local_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Google Sign-In
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    signInOption: SignInOption.standard,
  );

  // 🔹 Save user to Firestore if not exists
  Future<void> saveUser(User user, {String provider = 'firebase'}) async {
    final ref = _db.collection('users').doc(user.uid);
    final snap = await ref.get();

    if (!snap.exists) {
      await ref.set({
        'uid': user.uid,
        'name': user.displayName ?? "",
        'email': user.email ?? "",
        'photo': user.photoURL ?? "",
        'provider': provider,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // 🔐 Google Sign-In
  // AuthService file mein jayein
  Future<User?> googleSignIn() async {
    // 👈 void ki jagah User? likhein
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final result = await _auth.signInWithCredential(credential);
      await saveUser(result.user!, provider: 'google');

      return result.user; // 👈 Ye line add karein, tabhi error jayega
    } catch (e) {
      Get.snackbar("Google Login Failed", e.toString());
      return null; // Error aane par null bhejrein
    }
  }

  // 🔐 Facebook Sign-In
  Future<void> facebookSignIn() async {
    try {
      // Trigger the Facebook Login
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!.tokenString;

        final OAuthCredential facebookCredential =
            FacebookAuthProvider.credential(accessToken);

        final UserCredential userCredential = await _auth.signInWithCredential(
          facebookCredential,
        );

        await saveUser(userCredential.user!, provider: 'facebook');

        Get.offAllNamed("/mainlayout");
      } else if (result.status == LoginStatus.cancelled) {
        Get.snackbar(
          "Login Cancelled",
          "Facebook login was cancelled",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Login Failed",
          result.message ?? "Unknown error",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Facebook Login Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  static Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      LocalStorage.clear();

      Get.offAllNamed("/login");
    } catch (e) {
      print("LOGOUT ERROR: $e");
      Get.snackbar("Error", "Logout failed: $e");
    }
  }

  User? get currentUser => _auth.currentUser;
}
