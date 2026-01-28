import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Controllers/special_offers_controller.dart';
import 'package:ecommerce_app/Pages/special_offer_page.dart';
import 'package:ecommerce_app/ShimmerAll/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'most_popular.dart';

class SpecialOffers extends StatelessWidget {
  SpecialOffers({super.key});

  final controller = Get.put(SpecialOffersController());

  Future<QuerySnapshot<Map<String, dynamic>>> getSpecialOffersData() {
    return FirebaseFirestore.instance.collection('special_offers').get();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.showGrid.value = false;
        await controller.fetchCategories();
        await getSpecialOffersData();
        controller.startGridTimer();
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            _buildHeader(),

            const SizedBox(height: 12),

            /// SLIDER (Special Offers)
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: getSpecialOffersData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AppShimmer().sliderShimmer();
                }
                if (snapshot.hasData && !controller.showGrid.value) {
                  controller.startGridTimer();
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const SizedBox(height: 200);
                }
                final offers = snapshot.data!.docs;
                return _buildSlider(offers);
              },
            ),

            const SizedBox(height: 12),

            /// DYNAMIC GRID (Categories from Firestore)
            Obx(
              () =>
                  controller.showGrid.value &&
                      !controller.isCategoryLoading.value
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 90,
                          ),
                      itemCount: controller.categoryList.length,
                      itemBuilder: (_, index) {
                        final brand = controller.categoryList[index];
                        return _iconItem(brand);
                      },
                    )
                  : AppShimmer().gridShimmer(),
            ),

            /// MOST POPULAR
            MostPopular(),
          ],
        ),
      ),
    );
  }

  // Header Widget
  Widget _buildHeader() {
    return Row(
      children: [
        const SizedBox(width: 16),
        const Expanded(
          child: Text(
            'Special Offers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () => Get.to(() => SpecialOfferPage()),
          child: const Text('See All'),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  // Slider Widget
  Widget _buildSlider(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> offers,
  ) {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: controller.pageController,
            itemCount: offers.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(offers[index]['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(offers.length, (dot) => _buildDot(dot)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int dot) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: controller.currentPage.value == dot ? 20 : 6,
      height: 6,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: controller.currentPage.value == dot ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  /// ================= GRID ITEM =================

  /// ================= GRID ITEM =================

  Widget _iconItem(BrandModel model) {
    return InkWell(
      onTap: () {
        controller.navigateToCategory(model.title, model.categoryKey);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xffe9e9e9),
            child: Icon(model.icon, color: Colors.black),
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}
