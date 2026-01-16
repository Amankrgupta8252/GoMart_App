import 'package:ecommerce_app/HomePage/MostPopularPage/most_popular_controller.dart';
import 'package:ecommerce_app/mostPopular/most_popular_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';


class MostPopular extends StatelessWidget {
  MostPopular({super.key});

  final controller = Get.put(MostPopularController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          children: [
            const Expanded(
              child: Text(
                'Most Popular',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MostPopularPage(),
                  ),
                );
              },
              child: const Text('See All'),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Horizontal Categories
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.itemType.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Obx(
                      () => _categoryCard(
                    title: controller.itemType[index],
                    index: index,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            // childAspectRatio: 0.70

          ),
          itemCount: controller.images.length,
          itemBuilder: (_, index) {
            return _productCard(controller.images[index]);
          },
        ),
      ],
    );
  }

  // Category card
  Widget _categoryCard({required String title, required int index}) {
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Container(
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: controller.selectedIndex.value == index
              ? Colors.black
              : const Color(0xff8a8686),
        ),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // Product card
  Widget _productCard(Map<String, String> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: item["image"]!,
                  width: double.infinity,
                  // height: 150,
                  fit: BoxFit.cover,
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
              child: Text(" ${item["sold"]!} ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Text(item["price"]!,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

}
