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
    Track(icon: IconsaxPlusBold.truck_fast, isC: false), // Icon change for delivery
    Track(icon: IconsaxPlusBold.box_tick, isC: false), // Icon change for finished
  ];

  TrackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: List.generate(track.length, (index) {
          final data = track[index];
          return Expanded(
            child: Row(
              children: [
                /// ICON + CHECKMARK COLUMN
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      data.icon,
                      color: data.isC ? Colors.black : Colors.grey[400],
                      size: 28,
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      Icons.check_circle,
                      color: data.isC ? Colors.black : Colors.grey[300],
                      size: 20,
                    ),
                  ],
                ),

                if (index != track.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: track[index + 1].isC ? Colors.black : Colors.grey[300],
                      margin: const EdgeInsets.only(top: 36),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}