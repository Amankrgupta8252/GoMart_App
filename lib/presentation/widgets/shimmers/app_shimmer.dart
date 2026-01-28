import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer {
  // Is helper method ko bhi static banayein taaki homeShimmer ise use kar sake
  static Widget shimmerBox({
    double height = 20,
    double width = double.infinity,
    double radius = 6,
    bool circle = false,
    double size = 40,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: circle ? size : height,
        width: circle ? size : width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: circle
              ? BorderRadius.circular(size)
              : BorderRadius.circular(radius),
        ),
      ),
    );
  }

  static Widget _apply(Widget child) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }

  // Reusable Shimmer Box helper
  static Widget _box({double? h, double? w, double r = 8, bool circle = false}) {
    return _apply(
      Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: circle ? null : BorderRadius.circular(r),
        ),
      ),
    );
  }

  static Widget homeShimmer() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),

          /// 1. PROFILE HEADER SHIMMER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _box(h: 45, w: 45, circle: true),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(h: 12, w: 80),
                      const SizedBox(height: 8),
                      _box(h: 16, w: 130),
                    ],
                  ),
                ),
                _box(h: 35, w: 35, circle: true), // Bell Icon
                const SizedBox(width: 10),
                _box(h: 35, w: 35, circle: true), // Heart Icon
              ],
            ),
          ),

          const SizedBox(height: 25),

          /// 2. SEARCH BAR SHIMMER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _box(h: 50, r: 12),
          ),

          const SizedBox(height: 25),

          /// 3. SPECIAL OFFERS SLIDER SHIMMER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _box(h: 180, r: 25),
          ),

          const SizedBox(height: 25),

          /// 4. CATEGORIES GRID SHIMMER (8 Icons)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisExtent: 90,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 8,
            itemBuilder: (_, __) => Column(
              children: [
                _box(h: 55, w: 55, circle: true),
                const SizedBox(height: 8),
                _box(h: 10, w: 45),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// 5. MOST POPULAR TITLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _box(h: 20, w: 120),
                _box(h: 15, w: 50),
              ],
            ),
          ),

          const SizedBox(height: 15),

          /// 6. PRODUCT GRID SHIMMER (4 Cards)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.75,
            ),
            itemCount: 4,
            itemBuilder: (_, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _box(r: 15)), // Image
                const SizedBox(height: 8),
                _box(h: 15, w: 100), // Name
                const SizedBox(height: 6),
                _box(h: 12, w: 60), // Price
              ],
            ),
          ),
        ],
      ),
    );
  }
  /////// Special Offers  /////////////////

  Widget sliderShimmer() {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget gridShimmer() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        mainAxisSpacing: 8,
        mainAxisExtent: 90,
      ),
      itemCount: 10,
      itemBuilder: (_, index) {
        return Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: CircleAvatar(radius: 30, backgroundColor: Colors.white),
            ),
            const SizedBox(height: 6),
            shimmerLine(width: 40),
          ],
        );
      },
    );
  }

  Widget shimmerLine({double width = 40}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,

      highlightColor: Colors.grey.shade100,

      child: Container(height: 10, width: width, color: Colors.white),
    );
  }

  //////////////////// Most Popular //////////////////

  Widget productGridShimmer() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: 4,
      itemBuilder: (_, index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300, highlightColor: Colors.grey.shade100,
        child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16))),
      ),
    );
  }



}
