import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var productList = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  var quantity = 1.obs;
  var selectedSizeIndex = 0.obs;
  var selectedColorIndex = 0.obs;

  Future<void> fetchProductsByCategory(String categoryKey) async {
    try {
      isLoading(true);
      productList.clear();
      print("Fetching data for: $categoryKey");

      var snapshot = await _firestore
          .collection('products')
          .where('category', isEqualTo: categoryKey)
          .get();

      var data = snapshot.docs.map((doc) => {...doc.data(), "id": doc.id}).toList();
      productList.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void resetFilters() {
    quantity.value = 1;
    selectedSizeIndex.value = 0;
    selectedColorIndex.value = 0;
  }

  void increaseQty() => quantity.value++;
  void decreaseQty() { if (quantity.value > 1) quantity.value--; }
}