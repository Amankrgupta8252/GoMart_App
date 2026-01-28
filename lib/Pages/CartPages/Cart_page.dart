import 'package:ecommerce_app/Pages/CartPages/check_out.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../Controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxPlusBroken.search_normal),
          ),
        ],
      ),

      /// CART ITEMS
      body: Obx(
            () => Padding(
          padding: const EdgeInsets.all(16),
          child: controller.cartItems.isEmpty
              ? const Center(child: Text("Your cart is empty"))
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
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// IMAGE
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

                    /// INFO
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TITLE + DELETE
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
                              IconButton(
                                onPressed: () {
                                  _showRemoveSheet(context, index);
                                },
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          /// COLOR & SIZE
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 8,
                                backgroundColor:
                                Color(int.parse(item["Color"])),
                              ),
                              const SizedBox(width: 8),
                              const Text("Color"),
                              const SizedBox(width: 12),
                              const Text("|"),
                              const SizedBox(width: 12),
                              Text("Size: ${item["Size"]}"),
                            ],
                          ),

                          const SizedBox(height: 12),

                          /// PRICE + QTY
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
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xffe1dddd),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          controller.decreaseQty(index),
                                      child: const Icon(
                                          IconsaxPlusLinear.minus,
                                          size: 18),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      item["Qty"].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () =>
                                          controller.increaseQty(index),
                                      child: const Icon(
                                          IconsaxPlusLinear.add,
                                          size: 18),
                                    ),
                                  ],
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

      /// BOTTOM TOTAL BAR
      bottomNavigationBar: Obx(
            () => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Total Price",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${controller.totalPrice}.00",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: controller.cartItems.isEmpty ? null : () {
                  Get.to(CheckOut());
                },
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// REMOVE CONFIRMATION SHEET
  void _showRemoveSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Remove from Cart?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "Are you sure you want to remove this item from your cart?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.removeItem(index);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Remove"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
