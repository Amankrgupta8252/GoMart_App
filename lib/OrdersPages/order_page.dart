import 'package:ecommerce_app/OrdersPages/order_controller.dart';
import 'package:ecommerce_app/OrdersPages/OrderTracker/track_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPage extends StatelessWidget {
  OrderPage({super.key});

  final OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16),
          child: controller.cartItems.isEmpty
              ? _noResultFound()
              : ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.cartItems[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item["Image"],
                              width: 90,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item["Name"],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Color(
                                        int.parse(item["Color"]),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text("Color"),
                                    const SizedBox(width: 12),
                                    const Text("|"),
                                    const SizedBox(width: 12),
                                    Text("Size: ${item["Size"]}"),
                                    const SizedBox(width: 12),
                                    const Text("|"),
                                    const SizedBox(width: 12),
                                    Text("Qty: ${item["Qty"]}"),
                                  ],
                                ),

                                // const SizedBox(height: 12),
                                Container(
                                  width: 80,
                                  height: 25,

                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "In Delivery",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),

                                Row(
                                  children: [
                                    Text(
                                      "\$${item["Price"]}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),

                                      child: Container(
                                        width: 150,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        child: Center(
                                          child: TextButton(
                                            onPressed: () {
                                              Get.to(() => TrackOrder());
                                            },
                                            child: Text(
                                              "Track Order",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
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
                    );
                  },
                ),
        ),
      ),
    );
  }

  Widget _noResultFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVlfoW9-LcbEJImycyeUWCreWd0VMc314J4m1BhA2SmjZsWVEp",
        ),
        const SizedBox(height: 10),
        const Text(
          "No Result Found",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
