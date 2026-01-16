import 'package:ecommerce_app/specialOffers/special_offer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../MostPopularPage/most_popular.dart';
import 'special_offers_controller.dart';

class SpecialOffers extends StatelessWidget {
  SpecialOffers({super.key});

  final controller = Get.put(SpecialOffersController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Special Offers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SpecialOfferPage(),
                    ),
                  );
                },
                child: const Text('See All', style: TextStyle(fontSize: 15)),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// SLIDER
          Stack(
            children: [
              SizedBox(
                height: 140,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.items.length,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: AssetImage(
                              controller.items[index]["image"]!,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// DOT INDICATOR
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Obx(
                      () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.items.length,
                          (dot) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: controller.currentPage.value == dot ? 20 : 4,
                        height: 4,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == dot
                              ? Colors.black
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// BRANDS GRID
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            gridDelegate:
            const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              childAspectRatio: 0.8,
            ),
            itemCount: controller.brands.length,
            itemBuilder: (_, index) {
              return _iconItem(controller.brands[index]);
            },
          ),

          MostPopular(),
        ],
      ),
    );
  }

  Widget _iconItem(BrandModel model) {
    return InkWell(
      onTap: () {
        Get.to(() => model.page);
      }
      ,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xffe9e9e9),
            child: Icon(model.icon, color: Colors.black),
          ),
          const SizedBox(height: 6),
          Text(model.title),
        ],
      ),
    );
  }
}
