import 'dart:async';
import 'package:ecommerce_app/BagsPages/bags_page.dart';
import 'package:ecommerce_app/ClothesPages/clothes_page.dart';
import 'package:ecommerce_app/ElectronicsPages/electronics_page.dart';
import 'package:ecommerce_app/ShoesPages/shoes_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SpecialOffersController extends GetxController {
  final PageController pageController =
  PageController(viewportFraction: 0.98);

  var currentPage = 0.obs;
  Timer? _timer;

  final List<Map<String, String>> items = [
    {"image": "assets/image/image_5.jpg"},
    {"image": "assets/image/image_5.jpg"},
    {"image": "assets/image/image_5.jpg"},
    {"image": "assets/image/image_5.jpg"},
    {"image": "assets/image/image_5.jpg"},
  ];

  final brands = <BrandModel>[
  BrandModel(
  title: "Clothes",
  icon: PhosphorIconsFill.tShirt,
  page: ClothesPage(),
  ),

  BrandModel(
      title: "Shoes",
      icon: PhosphorIconsBold.sneakerMove,
      page: ShoesPage(),
    ),
    BrandModel(
      title: "Bags",
      icon: PhosphorIconsBold.backpack,
      page: BagsPage(),
    ),
    BrandModel(
      title: "Electronics",
      icon: PhosphorIconsBold.devices,
      page: ElectronicsPage(),
    ),
  ];


  @override
  void onInit() {
    super.onInit();
    _startAutoScroll();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (pageController.hasClients) {
        final nextPage = (currentPage.value + 1) % items.length;
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}

class BrandModel {
  final String title;
  final IconData icon;
  final Widget page;

  BrandModel({
    required this.title,
    required this.icon,
    required this.page,
  });
}

