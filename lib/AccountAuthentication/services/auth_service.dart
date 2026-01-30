import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'local_storage.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- Registration Logic ---
  static Future<User?> register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        await _db.collection('users').doc(result.user!.uid).set({
          'uid': result.user!.uid,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
          'photo': '', // Placeholder for profile page
        });
      }
      return result.user;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    }
  }

  // Login Logic
  static Future<User?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      Get.snackbar("Login Failed", "Invalid email or password");
      return null;
    }
  }

  // --- Profile Setup Logic ---
  static Future<bool> updateUserProfile({
    required String name,
    required String phone,
    required String address,
    required String dob,
    required String gender,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _db.collection('users').doc(user.uid).update({
          'name': name,
          'phone': phone,
          'address': address,
          'dob': dob,
          'gender': gender,
        });
        return true;
      }
      return false;
    } catch (e) {
      print("Update Error: $e");
      return false;
    }
  }

  // --- Logout Logic ---
  static Future<void> logout() async {
    try {
      await _auth.signOut();
      LocalStorage.clear();
      Get.offAllNamed("/login");
      Get.snackbar("Logged Out", "See you again soon! 👋");
    } catch (e) {
      Get.snackbar("Logout Error", e.toString());
    }
  }

  // --- Forgot Password Flow: 1. Generate OTP ---
  static Future<String?> generateAndSaveOTP(String input) async {
    try {
      QuerySnapshot result;
      if (input.contains('@')) {
        result = await _db.collection('users').where('email', isEqualTo: input).get();
      } else {
        result = await _db.collection('users').where('phone', isEqualTo: input).get();
      }

      if (result.docs.isNotEmpty) {
        String uid = result.docs.first.id;
        // 4-digit random OTP
        String otp = (1000 + (DateTime.now().millisecond % 9000)).toString();

        await _db.collection('password_resets').doc(uid).set({
          'otp': otp,
          'email': result.docs.first['email'],
          'expiresAt': DateTime.now().add(const Duration(minutes: 5)),
        });
        return otp;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // --- Forgot Password Flow: 2. Verify OTP ---
  static Future<bool> verifyOTP(String input, String enteredOtp) async {
    try {
      // Input se email/phone dhoondhein
      QuerySnapshot userRes = input.contains('@')
          ? await _db.collection('users').where('email', isEqualTo: input).get()
          : await _db.collection('users').where('phone', isEqualTo: input).get();

      if (userRes.docs.isNotEmpty) {
        String uid = userRes.docs.first.id;
        DocumentSnapshot resetDoc = await _db.collection('password_resets').doc(uid).get();

        if (resetDoc.exists) {
          String savedOtp = resetDoc['otp'];
          DateTime expiry = (resetDoc['expiresAt'] as Timestamp).toDate();

          if (savedOtp == enteredOtp && DateTime.now().isBefore(expiry)) {
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // --- Forgot Password Flow: 3. Update Password ---
  static Future<void> updatePasswordInFirestore(String input, String newPassword) async {
    try {
      QuerySnapshot userRes = input.contains('@')
          ? await _db.collection('users').where('email', isEqualTo: input).get()
          : await _db.collection('users').where('phone', isEqualTo: input).get();

      if (userRes.docs.isNotEmpty) {
        String uid = userRes.docs.first.id;
        // Password update in Firestore
        await _db.collection('users').doc(uid).update({
          'password': newPassword, // Security note: Ideally passwords shouldn't be plain text in Firestore
        });

        // Cleanup: Reset document delete karein taaki OTP reuse na ho
        await _db.collection('password_resets').doc(uid).delete();
      }
    } catch (e) {
      Get.snackbar("Update Error", e.toString());
    }
  }

  static Future<bool> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
  }


}