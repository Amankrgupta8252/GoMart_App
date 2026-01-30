import 'package:ecommerce_app/modules/OrdersPages/OrderTracker/tracking.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8), // Light background for better contrast
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent, // 👈 Isse color change hona band ho jayega
        elevation: 0,
        title: const Text(
          "Track Order",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxPlusBroken.search_normal),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- PRODUCT INFO CARD ---
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS4J5psHgg7ucQ-664XccsQAFWAzgds6D5Gm3KMALMFlSG5d-Er",
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Suga Leather Shoes",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.brown
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text("Color | Size: M | Qty: 1",
                                    style: TextStyle(color: Colors.grey, fontSize: 13)
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "\$375.00",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // --- TRACKING BAR (Horizontal Timeline) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TrackBar(),
              ),

              const SizedBox(height: 24),
              const Center(
                child: Text(
                  "Packet In Delivery",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(thickness: 1),
              ),

              // --- ORDER STATUS LIST ---
              const Text(
                "Order Status Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              const Tracking(), // Verticle Timeline

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}