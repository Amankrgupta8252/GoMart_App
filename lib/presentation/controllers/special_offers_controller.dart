import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/presentation/pages/categories/category_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SpecialOffersController extends GetxController {
  final PageController pageController = PageController(viewportFraction: 0.98);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var showGrid = false.obs;
  var currentPage = 0.obs;
  var isCategoryLoading = true.obs;
  var categoryList = <BrandModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isCategoryLoading(true);
      var snapshot = await _firestore.collection('category').orderBy('priority').get();

      var fetched = snapshot.docs.map((doc) {
        return BrandModel(
          title: doc['title'],
          icon: _getIconFromName(doc['iconName']),
          categoryKey: doc['categoryKey'],
        );
      }).toList();

      categoryList.assignAll(fetched);
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    } finally {
      isCategoryLoading(false);
    }
  }

  void navigateToCategory(String title, String key) {
    String cleanKey = key.replaceAll('_page', '');

    Get.to(() => CategoryProductPage(
      title: title,
      categoryKey: cleanKey,
    ));
  }

  IconData _getIconFromName(String name) {
    switch (name) {
      case 'tShirt' : return PhosphorIconsBold.tShirt;
      case 'sneakerMove': return PhosphorIconsBold.sneakerMove;
      case 'backpack': return PhosphorIconsBold.backpack;
      case 'devices': return PhosphorIconsBold.devices;
      case 'watch': return PhosphorIconsDuotone.watch;
      default: return PhosphorIconsBold.dotsThreeCircle;
    }
  }

  void startGridTimer() {
    Future.delayed(const Duration(seconds: 2), () {
      showGrid.value = true;
    });
  }

  void onPageChanged(int index) => currentPage.value = index;

  // Shimmer methods
  Widget sliderShimmer() {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget gridShimmer() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        mainAxisSpacing: 8,
        mainAxisExtent: 90,
      ),
      itemCount: 10,
      itemBuilder: (_, index) {
        return Column(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 10,
              width: 40,
              color: Colors.grey.shade300,
            ),
          ],
        );
      },
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

// Data Model
class BrandModel {
  final String title;
  final IconData icon;
  final String categoryKey;

  BrandModel({required this.title, required this.icon, required this.categoryKey});
}
