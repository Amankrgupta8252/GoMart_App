import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var wishlistItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWishlist();
  }

  void fetchWishlist() async {
    String? uid = _auth.currentUser?.uid;
    if (uid == null) return;

    _db.collection('users').doc(uid).collection('wishlist').snapshots().listen((snapshot) {
      var fetchedItems = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      wishlistItems.assignAll(fetchedItems);
    });
  }

  void toggleWishlist(Map<String, dynamic> product) async {
    String uid = _auth.currentUser!.uid;
    String productId = product['id'].toString();

    DocumentReference docRef = _db.collection('users').doc(uid).collection('wishlist').doc(productId);

    bool exists = wishlistItems.any((item) => item['id'] == productId);

    if (exists) {
      await docRef.delete();
    } else {
      await docRef.set(product);
    }
  }

  bool isFavorite(String productId) {
    return wishlistItems.any((item) => item['id'] == productId);
  }
}