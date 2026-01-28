import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return homeShimmer();
  }

  Widget homeShimmer() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 50),
          /// Top Row shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                shimmerBox(circle: true, size: 40),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerBox(width: 80, height: 12),
                      const SizedBox(height: 6),
                      shimmerBox(width: 120, height: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Search box shimmer
          Padding(
            padding: const EdgeInsets.all(16),
            child: shimmerBox(
              height: 50,
              width: double.infinity,
              radius: 10,
            ),
          ),

          /// Special offers shimmer list
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: shimmerBox(
                    height: 120,
                    width: double.infinity,
                    radius: 12,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmerBox({
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

}
