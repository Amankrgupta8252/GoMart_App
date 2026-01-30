import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/presentation/controllers/product_controller.dart';
import 'package:ecommerce_app/presentation/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'category_details_page.dart';

class CategoryProductPage extends StatelessWidget {
  final String title;
  final String categoryKey;

  CategoryProductPage({
    super.key,
    required this.title,
    required this.categoryKey,
  }) {
    Get.find<ProductController>().fetchProductsByCategory(categoryKey);
  }

  final controller = Get.put(ProductController());
  final wishlistController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(IconsaxPlusBroken.search_favorite),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }
        if (controller.productList.isEmpty) {
          return const Center(
            child: Text("No products found in this category"),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.productList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final item = controller.productList[index];
            String heroTag = "${categoryKey}_${item['id']}";
            return GestureDetector(
              onTap: () {
                controller.resetFilters();
                Get.to(() => CategoryDetailsPage(item: item, heroTag: heroTag));
              },
              child: _buildProductCard(item, heroTag),
            );
          },
        );
      }),
    );
  }

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
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: item['image'] ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey.shade200),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
}
