import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/ElectronicsPages/electronics_controller.dart';
import 'package:ecommerce_app/ElectronicsPages/electronics_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ElectronicsPage extends StatelessWidget {
  ElectronicsPage({super.key});

  final controller = Get.put(ElectronicsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Electronics",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxPlusLinear.search_normal_1),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            /// GRID
            Expanded(

              child: GridView.builder(
                itemCount: controller.images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  // childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  final item = controller.images[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ElectronicsDetailPage(item: item));
                    },
                    child: _productCard(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productCard(Map<String, String> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Hero(
                  tag: item["image"]!,
                  child: CachedNetworkImage(
                    imageUrl: item["image"]!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          item["title"]!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Icon(Icons.star),
            Text(
              "${item["rate"]!} | ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                " ${item["sold"]!} ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

        Text(
          item["price"]!,
          style: const TextStyle(fontWeight: FontWeight.bold, ),
        ),
      ],
    );
  }
}
