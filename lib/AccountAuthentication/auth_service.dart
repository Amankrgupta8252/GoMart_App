import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUser(User user) async {
    await _db.collection('users').doc(user.uid).set({
      'name': user.displayName,
      'email': user.email,
      'photo': user.photoURL,
      'provider': user.providerData.first.providerId,
      'createdAt': Timestamp.now(),
    }, SetOptions(merge: true));
  }

  // GOOGLE SIGN IN
  Future<void> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential result =
    await _auth.signInWithCredential(credential);

    await saveUser(result.user!);
  }
}
