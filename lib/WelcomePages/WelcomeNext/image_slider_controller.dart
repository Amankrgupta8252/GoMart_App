import 'package:ecommerce_app/AccountAuthentication/LoginPage/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageSliderController extends GetxController {
  final PageController pageController = PageController();
  final currentPage = 0.obs;

  final items = [
    {
      "image": "assets/image/image_1.jpg",
      "title": "We provide high quality products just for you",
      "button": "Next",
    },
    {
      "image": "assets/image/image_2.png",
      "title": "Your satisfaction is our number one priority",
      "button": "Next",
    },
    {
      "image": "assets/image/image_3.jpg",
      "title": "Let's fulfill your daily needs with Evira right now!",
      "button": "Get Start",
    },
  ];

  void nextPage() {
    if (currentPage.value < items.length - 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      /// ✅ Get Start → Login Page (no back)
      Get.off(() => const LoginPage());
    }
  }


  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
