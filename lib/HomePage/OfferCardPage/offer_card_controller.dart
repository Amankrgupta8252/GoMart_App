import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferCardController extends GetxController {
  final PageController pageController =
  PageController(viewportFraction: 0.95);

  var currentPage = 0.obs;
  Timer? _timer;

  final List<Map<String, String>> items = [
    {"image": "assets/image/image_5.jpg"},
    {"image": "assets/image/image_5.jpg"},
    {"image": "assets/image/image_5.jpg"},
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
