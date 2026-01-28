import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class Tracking extends StatelessWidget {
  const Tracking({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true, // ✅ VERY IMPORTANT
      physics: const NeverScrollableScrollPhysics(), // ✅
      children: const [
        OrderStep(
          title: "Order Placed",
          subtitle: "We have received your order",
          isCompleted: true,
          isLast: false,
        ),
        OrderStep(
          title: "Order Confirmed",
          subtitle: "Your order has been confirmed",
          isCompleted: true,
          isLast: false,
        ),
        OrderStep(
          title: "Packed",
          subtitle: "Items are packed and ready",
          isCompleted: true,
          isLast: false,
        ),
        OrderStep(
          title: "Shipped",
          subtitle: "Your order is on the way",
          isCompleted: false,
          isLast: false,
        ),
        OrderStep(
          title: "Out for Delivery",
          subtitle: "Courier is near your location",
          isCompleted: false,
          isLast: false,
        ),
        OrderStep(
          title: "Delivered",
          subtitle: "Order delivered successfully",
          isCompleted: false,
          isLast: true,
        ),
      ],
    );
  }
}


class OrderStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isLast;

  const OrderStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TIMELINE
        Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? Colors.green : Colors.grey[300],
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: isCompleted ? Colors.green : Colors.grey[300],
              ),
          ],
        ),

        const SizedBox(width: 12),

        /// CONTENT
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------

class Track {
  final IconData icon;
  final bool isC;

  Track({required this.icon, required this.isC});
}

class TrackBar extends StatelessWidget {
  final List<Track> track = <Track>[
    Track(icon: IconsaxPlusBold.box, isC: true),
    Track(icon: IconsaxPlusBold.truck, isC: true),
    Track(icon: CupertinoIcons.group, isC: false),
    Track(icon: Icons.add_box_outlined, isC: false),
  ];
  TrackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(track.length * 2 - 1, (i) {
        if (i.isEven) {
          final data = track[i ~/ 2];
          return Center(
            child: Column(
              children: [
                Icon(data.icon),
                const SizedBox(height: 6),
                Icon(
                  CupertinoIcons.checkmark_circle_fill,
                  color: data.isC ? Colors.black : Colors.grey,
                ),
              ],
            ),
          );
        } else {
          final next = track[(i ~/ 2) + 1];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: 2,
            width: 40,
            color: next.isC ? Colors.black : Colors.grey,
          );
        }
      }),
    );
  }
}
