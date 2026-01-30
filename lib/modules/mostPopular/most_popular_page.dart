import 'package:ecommerce_app/presentation/pages/categories/category_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:ecommerce_app/presentation/controllers/most_popular_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MostPopularPage extends StatelessWidget {
  MostPopularPage({super.key});

  // Purane controller ko hi find kar rahe hain taaki data sync rahe
  final controller = Get.find<MostPopularController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Most Popular",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxPlusLinear.search_normal_1, color: Colors.black),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          /// --- CATEGORY SELECTOR ---
          SizedBox(
            height: 40,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: controller.itemType.length,
              itemBuilder: (context, index) => _buildCategoryItem(index),
            ),
          ),

          const SizedBox(height: 16),

          /// --- DYNAMIC PRODUCT GRID ---
          Expanded(
            child: Obx(() {
              if (controller.isLoadingProducts.value) {
                return const Center(child: CircularProgressIndicator(color: Colors.black));
              }
              if (controller.filteredProducts.isEmpty) {
                return const Center(child: Text("No products found"));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.7, // Match with CategoryProductPage
                ),
                itemBuilder: (context, index) {
                  final item = controller.filteredProducts[index];
                  String heroTag = "popular_page_${item['id']}_$index";
                  return _buildProductCard(item, heroTag);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  /// Category Item Widget
  Widget _buildCategoryItem(int index) {
    return Obx(() => GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 22),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: controller.selectedIndex.value == index ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: Text(
          controller.itemType[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: controller.selectedIndex.value == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    ));
  }

  /// Product Card UI (Matches your Category design)
  Widget _buildProductCard(Map<String, dynamic> item, String tag) {
    return GestureDetector(
      onTap: () => Get.to(() => CategoryDetailsPage(item: item, heroTag: tag)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: tag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: item['image'] ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => Container(color: Colors.grey.shade100),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Icons.favorite_border, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(item['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 14),
              Text(" ${item['rate'] ?? '0'} | ${item['sold'] ?? '0'} sold", style: const TextStyle(fontSize: 12)),
            ],
          ),
          Text("\$${item['price'] ?? '0'}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}