import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          
          IconButton(onPressed: (){}, icon: Icon(IconsaxPlusLinear.more_circle,size: 30,)),
          
          
          // Container(
          //   width: 30,
          //   height: 30,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15),
          //     border: Border.all(color: Color(0xff000000)),
          //   ),
          //
          //   child: Row(
          //     children: List.generate(
          //       3,
          //       (index) => Container(
          //         width: 6,
          //         height: 6,
          //         margin: EdgeInsets.symmetric(horizontal: 2),
          //         decoration: BoxDecoration(
          //           color: Colors.black,
          //           shape: BoxShape.circle,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _notificationCard(
            "New Arrival",
            "Check out our latest collection of summer wear!",
            "2 hours ago",
            PhosphorIconsBold.package,
            Colors.blue,
          ),
          _notificationCard(
            "Special Offer",
            "Get 50% off on selected items. Limited time offer!",
            "5 hours ago",
            PhosphorIconsBold.tag,
            Colors.red,
          ),
          _notificationCard(
            "Order Delivered",
            "Your order #12345 has been delivered successfully.",
            "1 day ago",
            PhosphorIconsBold.checkCircle,
            Colors.green,
          ),
          _notificationCard(
            "Payment Successful",
            "Your payment of \$99.99 has been processed.",
            "2 days ago",
            PhosphorIconsBold.creditCard,
            Colors.purple,
          ),
          _notificationCard(
            "Wishlist Reminder",
            "Items in your wishlist are now on sale!",
            "3 days ago",
            PhosphorIconsBold.heart,
            Colors.pink,
          ),
        ],
      ),
    );
  }

  Widget _notificationCard(
    String title,
    String message,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          
          SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          IconButton(
            onPressed: () {
              // Mark as read or delete notification
            },
            icon: Icon(
              IconsaxPlusLinear.more_2,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
