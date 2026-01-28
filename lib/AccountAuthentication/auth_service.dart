import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  Future<void> googleSignIn() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final result = await _auth.signInWithCredential(credential);
      await saveUser(result.user!, provider: 'google');

      Get.offAllNamed("/mainlayout");
    } catch (e) {
      Get.snackbar("Google Login Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
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


        // Create a credential for Firebase
        final OAuthCredential facebookCredential =
        FacebookAuthProvider.credential(accessToken);

        final UserCredential userCredential =
        await _auth.signInWithCredential(facebookCredential);

        await saveUser(userCredential.user!, provider: 'facebook');

        Get.offAllNamed("/mainlayout");
      } else if (result.status == LoginStatus.cancelled) {
        Get.snackbar("Login Cancelled", "Facebook login was cancelled",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Login Failed", result.message ?? "Unknown error",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Facebook Login Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // 🚪 Logout (Google + Facebook + Firebase)
  Future<void> logout() async {
    try {
      // Logout from all providers
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      await _auth.signOut();

      Get.offAllNamed("/login");
    } catch (e) {
      Get.snackbar("Logout Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // ✅ Optional: Get current user
  User? get currentUser => _auth.currentUser;
}
