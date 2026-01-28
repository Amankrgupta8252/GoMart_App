import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SpecialShimmer extends StatelessWidget {
  const SpecialShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SpecialShimmer();
  }

  Widget specialShimmer() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 50),

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
