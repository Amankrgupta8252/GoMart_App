import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MostPopularController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  var selectedIndex = 0.obs;
  var isLoadingProducts = true.obs;

  var allProducts = <Map<String, dynamic>>[].obs;
  var filteredProducts = <Map<String, dynamic>>[].obs;

  final List<String> itemType = ["All", "Shoes", "Bags", "Watch", "Clothes"];

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // Firebase Firestore se data fetch karna
  void fetchProducts() async {
    try {
      isLoadingProducts.value = true;

      // 'products' collection se data stream/get karna
      _db.collection('products').snapshots().listen((snapshot) {
        var tempList = snapshot.docs.map((doc) {
          return {
            "id": doc.id,
            ...doc.data(),
          };
        }).toList();

        allProducts.assignAll(tempList);

        // Initial load par filtered list update karna
        applyFilter();
        isLoadingProducts.value = false;
      });
    } catch (e) {
      isLoadingProducts.value = false;
      Get.snackbar("Error", "Data nahi mil raha: $e");
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    applyFilter();
  }

  void applyFilter() {
    String category = itemType[selectedIndex.value];
    if (category == "All") {
      filteredProducts.assignAll(allProducts);
    } else {
      var filtered = allProducts.where((p) {
        return p["category"].toString().toLowerCase() == category.toLowerCase();
      }).toList();
      filteredProducts.assignAll(filtered);
    }
  }
}