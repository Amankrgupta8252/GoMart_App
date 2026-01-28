import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/shipping_address_controller.dart';

class ShippingAddress extends StatelessWidget {
  ShippingAddress({super.key});

  final ShippingAddressController controller =
  Get.put(ShippingAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Shipping Address",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.addressList.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  final isSelected =
                      controller.selectedIndex.value == index;
                  final address = controller.addressList[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),

                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: const Color(0xff7e7b7b),
                          ),
                          child: Center(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.black,
                              ),
                              child: const Icon(
                                Icons.location_on_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address["title"]!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                address["address"]!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),

                        Radio<int>(
                          value: index,
                          groupValue: controller.selectedIndex.value,
                          onChanged: (value) {
                            controller.selectAddress(value!);
                          },
                          activeColor: Colors.black,
                        )

                      ],
                    ),

                  );
                });
              },

            ),
          ),

          /// ADD NEW ADDRESS BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                },
                label: const Text(
                  "Apply",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(30),

                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
