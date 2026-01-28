import 'package:ecommerce_app/presentation/controllers/offer_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferCard extends StatelessWidget {
  OfferCard({super.key});

  final controller = Get.put(OfferCardController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Special Offers",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// SLIDER
                    Container(
                      width: double.infinity,
                      height: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffe3e3e3),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 160,
                            child: PageView.builder(
                              controller: controller.pageController,
                              itemCount: controller.items.length,
                              onPageChanged: controller.onPageChanged,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      controller.items[index]["image"]!,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          /// DOT INDICATOR
                          Obx(
                                () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                controller.items.length,
                                    (dot) => AnimatedContainer(
                                  duration:
                                  const Duration(milliseconds: 300),
                                  width: controller.currentPage.value == dot
                                      ? 28
                                      : 8,
                                  height: 8,
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color:
                                    controller.currentPage.value == dot
                                        ? Colors.black
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// ICON GRID
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (_) => _iconItem()),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (_) => _iconItem()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _iconItem() {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xffb6b5b5),
          ),
        ),
        SizedBox(height: 6),
        Text("Data"),
      ],
    );
  }
}
