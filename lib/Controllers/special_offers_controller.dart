import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Pages/Categorys/category_product_page.dart';
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