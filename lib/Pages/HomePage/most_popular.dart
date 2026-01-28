import 'package:ecommerce_app/Pages/mostPopular/most_popular_detail_page.dart';
import 'package:ecommerce_app/Pages/mostPopular/most_popular_page.dart';
import 'package:ecommerce_app/ShimmerAll/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../Controllers/most_popular_controller.dart';


class MostPopular extends StatelessWidget {
  MostPopular({super.key});

  final controller = Get.put(MostPopularController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TITLE
        Row(
          children: [
            const SizedBox(width: 16),
            const Expanded(child: Text('Most Popular', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            TextButton(
              onPressed: () => Get.to(() => MostPopularPage()),
              child: const Text('See All'),
            ),
            const SizedBox(width: 16),
          ],
        ),

        /// CATEGORY ROW
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.itemType.length,
            itemBuilder: (_, index) => _categoryCard(title: controller.itemType[index], index: index),
          ),
        ),

        const SizedBox(height: 12),

        /// GRID (Shimmer or Real)
        Obx(() => controller.isLoadingProducts.value ? AppShimmer().productGridShimmer() : productGrid()),
      ],

    );

  }

  Widget productGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.8,
      ),
      itemCount: 4, // Home screen par sirf top 4 dikhao
      itemBuilder: (_, index) => _productCard(controller.images[index], "home_hero_$index"),
    );
  }

  Widget _productCard(Map<String, String> item, String tag) {
    return GestureDetector(
      onTap: () => Get.to(() => MostPopularDetailPage(item: item, heroTag: tag), ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack( // Stack use kiya taaki image ke upar heart aa sake
              children: [
                /// PRODUCT IMAGE WITH HERO
                Hero(
                  tag: tag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: item["image"]!,
                      width: double.infinity,
                      height: double.infinity, // Expand to fill stack
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// HEART ICON (Wishlist)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      // Yahan heart toggle ka logic likh sakte hain
                      print("${item['title']} added to wishlist");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black54, // Circle background
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border, // Khali heart. Bhara hua ke liye Icons.favorite use karein
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          /// PRODUCT TITLE
          Text(
            item["title"]!,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

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

          /// PRODUCT PRICE
          Text(
            item["price"]!,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // --- Category Card & Shimmer functions are same as yours ---
  Widget _categoryCard({required String title, required int index}) {
    return Obx(() => GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: controller.selectedIndex.value == index ? Colors.black : const Color(
              0xffffff),
          border: Border.all(color: Color(0xff000000))
        ),
        child: Text(title, style: TextStyle(color: controller.selectedIndex.value == index ? Colors.white : Colors.black)),
      ),
    ));
  }


}