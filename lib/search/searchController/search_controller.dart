import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchControllerX extends GetxController {
  final searchController = TextEditingController();

  // 🔹 Filters
  final category = [
    'All',
    'Clothes',
    'Shoes',
    'All',
    'Clothes',
    'Shoes',
  ];

  final sortBy = [
    'All',
    'Clothes',
    'Shoes',
    'All',
    'Clothes',
    'Shoes',
  ];

  final rating = ['⭐ All', '⭐ 5', '⭐ 4', '⭐ 3', '⭐ 2', '⭐ 1'];

  // 🔹 Data
  final allData = <Map<String, String>>[
    {
      "image":
      "https://miro.medium.com/v2/resize:fit:1100/format:webp/0*f8p_nFCjZwsaTS-M",
      "title": "Snake Leather Bag",
      "rate": "4.5",
      "sold": "8,374",
      "price": "\$445.00",
    },
    {
      "image": "https://images.unsplash.com/photo-1626947346165-4c2288dadc2a",
      "title": "Suga Leather Shoes",
      "rate": "4.7",
      "sold": "7,483",
      "price": "\$375.00",
    },
  ].obs;

  final filteredData = <Map<String, String>>[].obs;

  @override
  void onInit() {
    filteredData.assignAll(allData);
    super.onInit();
  }

  // 🔍 SEARCH
  void onSearch(String query) {
    final text = query.toLowerCase().trim();

    if (text.isEmpty) {
      filteredData.assignAll(allData);
      return;
    }

    filteredData.assignAll(
      allData.where(
            (item) => item['title']!.toLowerCase().contains(text),
      ),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
