import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/presentation/controllers/product_controller.dart';
import 'package:ecommerce_app/presentation/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailsPage extends StatelessWidget {
  final Map<String, dynamic> item;
  final String heroTag;
  final controller = Get.put(ProductController());
  final wishlistController = Get.put(WishlistController());

  Color getColorFromName(String colorName) {
    switch (colorName.toLowerCase().trim()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'black':
        return Colors.black;
      case 'green':
        return Colors.green;
      case 'white':
        return Colors.white;
      case 'grey':
        return Colors.grey;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.blueGrey;
    }
  }

  CategoryDetailsPage({super.key, required this.item, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> firebaseSizes = item['size'] is List
        ? item['size']
        : (item['size'] != null ? [item['size']] : []);
    final List<dynamic> firebaseColors = item['color'] is List
        ? item['color']
        : ["Red", "Blue", "Black", "Green"];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: heroTag,
                  child: CachedNetworkImage(
                    imageUrl: item['image'],
                    height: 450,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: const BackButton(color: Colors.black),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Obx(() {
                          bool isFav = wishlistController.isFavorite(
                            item['id'],
                          );
                          return GestureDetector(
                            onTap: () =>
                                wishlistController.toggleWishlist(item),
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
                  const SizedBox(height: 10),
                  _buildRatingRow(),
                  const Divider(height: 30),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['description'] ?? '',
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),

                  const SizedBox(height: 20),
                  if (firebaseSizes.isNotEmpty) ...[
                    const Text(
                      "Size",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: List.generate(
                        firebaseSizes.length,
                        (index) => _buildChip(
                          firebaseSizes[index].toString(),
                          index,
                          controller.selectedSizeIndex,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  if (firebaseColors.isNotEmpty) ...[
                    const Text(
                      "Color",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 12,
                      children: List.generate(
                        firebaseColors.length,
                        (index) => _buildColorCircle(
                          firebaseColors[index].toString(),
                          index,
                          controller.selectedColorIndex,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBottomBar(),
      ),
    );
  }

  // Helper Widgets for cleaner code
  Widget _buildRatingRow() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        Text(
          " ${item['rate']} (${item['reviews']} reviews)",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(width: 10),
        const Text("|"),
        const SizedBox(width: 10),
        Text(
          "${item['sold']} sold",
          style: const TextStyle(color: Colors.grey),
        ),
        const Spacer(), // 👈 Ye quantity selector ko right side push kar dega
        _buildQtySelector(),
      ],
    );
  }

  Widget _buildChip(String label, int index, RxInt selectedProp) {
    return GestureDetector(
      onTap: () => selectedProp.value = index,
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: selectedProp.value == index
                ? Colors.black
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selectedProp.value == index ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQtySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100, // Light background
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300), // Subtle border
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease Button
          GestureDetector(
            onTap: controller.decreaseQty,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: Icon(Icons.remove, size: 16, color: Colors.black),
            ),
          ),

          // Quantity Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Obx(
                  () => Text(
                "${controller.quantity.value}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Increase Button
          GestureDetector(
            onTap: controller.increaseQty,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.black, // Dark background for contrast
              child: Icon(Icons.add, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$${item['price']}",
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: const StadiumBorder(),
          ),
          onPressed: () => Get.snackbar("Cart", "Added to cart!"),
          child: const Text(
            "Add to Cart",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildColorCircle(String colorName, int index, RxInt selectedProp) {
    Color circleColor = getColorFromName(colorName);

    return GestureDetector(
      onTap: () => selectedProp.value = index,
      child: Obx(() {
        bool isSelected = selectedProp.value == index;
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: circleColor,
            child: isSelected
                ? Icon(
                    Icons.check,
                    size: 18,
                    color: circleColor == Colors.white
                        ? Colors.black
                        : Colors.white,
                  )
                : (circleColor == Colors.white
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                        )
                      : null),
          ),
        );
      }),
    );
  }
}
