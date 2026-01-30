import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/presentation/controllers/most_popular_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MostPopularDetailPage extends StatelessWidget {
  final Map<String, String> item;
  final String heroTag; // Unique tag for animation

  MostPopularDetailPage({super.key, required this.item, required this.heroTag});

  // Inject the specific controller for this page
  final controller = Get.put(MostPopularDetailController());

  final List<String> sizes = ["S", "M", "L", "XL"];
  final List<String> colors = ["Red", "Blue", "Green", "Gray"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE WITH HERO
            Stack(
              children: [
                // 1. HERO WIDGET HERE
                Hero(
                  tag: heroTag,
                  child: CachedNetworkImage(
                    imageUrl: item["image"]!,
                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Back Button
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE & FAVORITE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item["title"]!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),
                    ],
                  ),

                  /// RATINGS & SOLD
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${item["sold"]!} sold",
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        item["rate"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      const Text("(120 reviews)", style: TextStyle(color: Colors.grey)),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),

                  /// DESCRIPTION
                  const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    "This is a premium quality ${item['title']} designed for comfort and style. Perfect for daily use and special occasions.",
                    style: const TextStyle(color: Colors.grey, height: 1.5),
                  ),

                  const SizedBox(height: 20),

                  /// SIZE SELECTION
                  const Text("Size", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    children: List.generate(sizes.length, (index) => _sizeOption(index)),
                  ),

                  const SizedBox(height: 20),

                  /// COLOR SELECTION
                  const Text("Color", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    children: List.generate(colors.length, (index) => _colorOption(index)),
                  ),

                  const SizedBox(height: 20),

                  /// QUANTITY
                  Row(
                    children: [
                      const Text("Quantity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200
                        ),
                        child: Row(
                          children: [
                            IconButton(onPressed: controller.decrement, icon: const Icon(Icons.remove)),
                            Obx(() => Text("${controller.quantity.value}", style: const TextStyle(fontWeight: FontWeight.bold))),
                            IconButton(onPressed: controller.increment, icon: const Icon(Icons.add)),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// BOTTOM BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Total Price", style: TextStyle(color: Colors.grey)),
                            Text(item["price"]!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_bag_outlined, color: Colors.white),
                              SizedBox(width: 8),
                              Text("Add to Cart", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sizeOption(int index) {
    return GestureDetector(
      onTap: () => controller.changeSize(index),
      child: Obx(() {
        bool isSelected = controller.selectedSizeIndex.value == index;
        return Container(
          width: 45,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            sizes[index],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        );
      }),
    );
  }

  Widget _colorOption(int index) {
    return GestureDetector(
      onTap: () => controller.changeColor(index),
      child: Obx(() {
        bool isSelected = controller.selectedColorIndex.value == index;
        return Container(
          padding: const EdgeInsets.all(2), // border width
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: _getColor(colors[index]),
            radius: 18,
          ),
        );
      }),
    );
  }

  Color _getColor(String color) {
    switch (color.toLowerCase()) {
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'gray': return Colors.grey;
      default: return Colors.black;
    }
  }
}