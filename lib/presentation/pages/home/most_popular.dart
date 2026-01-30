import 'package:ecommerce_app/modules/mostPopular/most_popular_page.dart';
import 'package:ecommerce_app/presentation/controllers/wishlist_controller.dart';
import 'package:ecommerce_app/presentation/pages/categories/category_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/presentation/controllers/most_popular_controller.dart';
import 'package:ecommerce_app/presentation/widgets/shimmers/app_shimmer.dart';
// Detail page import karein jahan click par jana hai

class MostPopular extends StatelessWidget {
  MostPopular({super.key});

  final WishlistController wishlistController = Get.put(WishlistController());
  final controller = Get.put(MostPopularController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TITLE SECTION
        Row(
          children: [
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Most Popular',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () => Get.to(MostPopularPage()),
              child: const Text('See All'),
            ),
            const SizedBox(width: 16),
          ],
        ),

        /// CATEGORY SELECTOR
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

        /// DYNAMIC GRID WITH OBX
        Obx(() {
          if (controller.isLoadingProducts.value) {
            return AppShimmer().productGridShimmer();
          }

          if (controller.filteredProducts.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Text("No products found in this category"),
              ),
            );
          }

          return productGrid();
        }),
      ],
    );
  }

  Widget productGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(12), // Same as CategoryProductPage
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.7, // Updated to match CategoryProductPage
      ),
      itemCount: controller.filteredProducts.length,
      itemBuilder: (context, index) {
        final item = controller.filteredProducts[index];
        // Dynamic hero tag
        String heroTag = "most_popular_${item['id']}_$index";

        return GestureDetector(
          onTap: () {
            Get.to(() => CategoryDetailsPage(item: item, heroTag: heroTag));
          },
          child: _buildProductCard(item, heroTag),
        );
      },
    );
  }

  /// Exactly the same UI as CategoryProductPage
  Widget _buildProductCard(Map<String, dynamic> item, String tag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Hero(
                tag: tag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Same radius
                  child: CachedNetworkImage(
                    imageUrl: item['image'] ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => Container(color: Colors.grey.shade200),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Obx(() {
                  bool isFav = wishlistController.isFavorite(item['id']);
                  return GestureDetector(
                    onTap: () => wishlistController.toggleWishlist(item),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.white : Colors.black,


                        size: 20,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item['title'] ?? 'No Title',
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 14),
            Text(
              " ${item['rate'] ?? '0'} | ${item['sold'] ?? '0'} sold",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        Text(
          "\$${item['price'] ?? '0'}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _categoryCard({required String title, required int index}) {
    return Obx(() => GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 22),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: controller.selectedIndex.value == index ? Colors.black : Colors.white,
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: Text(
            title,
            style: TextStyle(
                color: controller.selectedIndex.value == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    ));
  }
}