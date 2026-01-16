import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'clothes_Controller.dart';

class ClothesDetailPage extends StatelessWidget {
  final Map<String, String> item;

  ClothesDetailPage({super.key, required this.item});

  final controller = Get.find<ClothesController>();

  final List<String> sizes = ["S", "M", "L", "XL"];
  final List<String> colors = ["Red", "Blue", "Green","Gray"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: item["image"]!,
                  transitionOnUserGestures: true,
                  child: CachedNetworkImage(
                    imageUrl: item["image"]!,
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
                // IconButton(onPressed: (){
                //   Get.back();
                // }, icon: Icon(Icons.arrow_back),),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item["title"]!,
                              style: const TextStyle(
                                fontSize: 20,
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

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item["sold"]!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.star, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            item["rate"]!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          Text("(${item["reviews"]})"),
                        ],
                      ),

                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),

                      /// DESCRIPTION
                      const Text(
                        "Description",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(item["description"]!),

                      const SizedBox(height: 10),

                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    const Text(
                                      "Size",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 10,
                                      children: sizes.map((size) => _SizeCard(size)).toList(),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    const Text(
                                      "Color",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 10,
                                      children: colors.map((color) => _ColorCard(color)).toList(),
                                    ),
                                  ],
                                ),



                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          const Text("Quantity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          const SizedBox(width: 10,),
                          Row(
                            children: [
                              IconButton(onPressed: (){}, icon: Icon(Icons.remove),),
                              Text("1", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              IconButton(onPressed: (){}, icon: Icon(Icons.add),),
                            ],
                          )

                        ],
                      ),



                      const SizedBox(height: 24),
                      const Divider(),

                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade300,
                                  foregroundColor: Colors.black26,
                                ),
                                onPressed: () {},
                                child: Text(
                                  item["price"]!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          /// ADD TO CART BUTTON
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {},

                                child: Row(
                                  children: [
                                    Icon(Icons.shopping_cart),
                                    SizedBox(width: 8,),
                                    Text("Add to Cart", style: TextStyle(fontSize: 16),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }

  Widget _SizeCard(String size) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black26),
      ),
      child: Text(size, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _ColorCard(String color) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black26),
      ),
      child: Text(color, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }


}
