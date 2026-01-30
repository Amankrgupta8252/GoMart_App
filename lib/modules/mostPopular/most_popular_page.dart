import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/presentation/controllers/most_popular_controller.dart';
import 'most_popular_detail_page.dart'; // Detail page import karein

class MostPopularPage extends StatelessWidget {
  MostPopularPage({super.key});

  // Controller ko initialize kar rahe hain
  final controller = Get.put(MostPopularController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Most Popular",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxPlusLinear.search_normal_1),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          /// --- CATEGORY LIST ---
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: controller.itemType.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Obx(
                        () => GestureDetector(
                      onTap: () => controller.changeCategory(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == index
                              ? Colors.black
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(
                          controller.itemType[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: controller.selectedIndex.value == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          /// --- PRODUCT GRID ---
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75, // Card ki height set karne ke liye
              ),
              itemBuilder: (context, index) {
                final item = controller.images[index];
                // Har item ko ek unique tag de rahe hain Hero animation ke liye
                final String heroTag = "popular_hero_$index";

                return _productCard(context, item, heroTag);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// --- PRODUCT CARD WIDGET ---
  Widget _productCard(BuildContext context, Map<String, String> item, String tag) {
    return GestureDetector(
      onTap: () {
        // Detail page par bhej rahe hain data aur hero tag ke sath
        Get.to(() => MostPopularDetailPage(item: item, heroTag: tag));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                // Image Animation Start point
                Hero(
                  tag: tag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: item["image"]!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey.shade200),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                // Wishlist Icon
                const Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.favorite_border, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Title
          Text(
            item["title"]!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          // Ratings
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                "${item["rate"]!} | ",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  item["sold"]!,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),

          // Price
          Text(
            item["price"]!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}