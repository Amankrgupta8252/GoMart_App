import 'package:ecommerce_app/Controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final List<String> category = [
    "Shoes",
    "Clothes",
    "Watches",
    "Bags",
  ];

  final List<String> sortBy = [
    "Popular",
    "Newest",
    "Price: Low to High",
    "Price: High to Low",
  ];

  final List<String> rating = [
    "⭐ All",
    "⭐ 5",
    "⭐ 4",
    "⭐ 3",
    "⭐ 2",
    "⭐ 1"
  ];


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchControllerX());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          children: [
            /// 🔍 SEARCH FIELD
            TextField(
              controller: controller.searchController,
              autofocus: true,
              onChanged: controller.onSearch,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  IconsaxPlusLinear.search_normal_1,
                  color: Color(0xffb9b9b9),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(PhosphorIconsBold.slidersHorizontal),
                  onPressed: () => _showBottomSheet(context),
                ),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// 📊 HEADER
            Obx(
                  () => Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.searchController.text.isEmpty
                          ? 'Results'
                          : 'Result for "${controller.searchController.text}"',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${controller.filteredData.length} Found',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: Obx(
                    () => controller.filteredData.isEmpty
                    ? _noResult()
                    : GridView.builder(
                  itemCount: controller.filteredData.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.62,
                  ),
                  itemBuilder: (_, index) =>
                      _productCard(controller.filteredData[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🧱 PRODUCT CARD
  Widget _productCard(Map<String, String> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item["image"]!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: const Icon(Icons.favorite_border,
                    color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          item["title"]!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(item["price"]!),
      ],
    );
  }

  Widget _noResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVlfoW9-LcbEJImycyeUWCreWd0VMc314J4m1BhA2SmjZsWVEp"),
        const SizedBox(height: 10),
        const Text(
          "No Result Found",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }


  Widget _bottomButton(String text, Color bg, Color textColor) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: bg,
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  /// ⬆️ BOTTOM SHEET (UI only
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            RangeValues priceRange = const RangeValues(10, 80);

            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.8,
              minChildSize: 0.4,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ⬆️ DRAG HANDLE
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Center(
                        child: Text(
                          'Sort & Filter',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      Divider(color: Colors.grey.shade400),

                      /// 📂 CATEGORIES
                      const SizedBox(height: 24),
                      const Text(
                        "Categories",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(category.length, (index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(category[index]),
                            );
                          }),
                        ),
                      ),

                      /// 💰 PRICE RANGE
                      const SizedBox(height: 24),
                      const Text(
                        "Price Range",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),

                      RangeSlider(
                        values: priceRange,
                        min: 1,
                        max: 100,
                        divisions: 100,
                        labels: RangeLabels(
                          "\$${priceRange.start.round()}",
                          "\$${priceRange.end.round()}",
                        ),
                        onChanged: (value) {
                          setModalState(() {
                            priceRange = value;
                          });
                        },
                      ),

                      /// 🔽 SORT BY
                      const SizedBox(height: 20),
                      const Text(
                        "Sort By",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(sortBy.length, (index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(sortBy[index]),
                            );
                          }),
                        ),
                      ),

                      /// ⭐ RATING
                      const SizedBox(height: 24),
                      const Text(
                        "Rating",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(rating.length, (index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(rating[index]),
                            );
                          }),
                        ),
                      ),

                      const SizedBox(height: 24),
                      Divider(color: Colors.grey.shade400),

                      /// 🔘 BUTTONS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _bottomButton("Reset", Colors.black, Colors.white),
                          const SizedBox(width: 20),
                          _bottomButton("Apply", Colors.grey, Colors.black),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }



}
