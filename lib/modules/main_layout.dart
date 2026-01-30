import 'package:ecommerce_app/modules/CartPages/Cart_page.dart';
import 'package:ecommerce_app/modules/OrdersPages/top_nav.dart';
import 'package:ecommerce_app/modules/ProfilePages/profile_page.dart';
import 'package:ecommerce_app/modules/WalletPages/wallet_page.dart';
import 'package:ecommerce_app/presentation/controllers/bottom_nav_controller.dart';
import 'package:ecommerce_app/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainLayout extends StatelessWidget {
  MainLayout({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  final pages = [
    const HomePage(),
    CartPage(),
    const TopNav(),
    const WalletPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
            () => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25), // withOpacity ki jagah withAlpha for latest Flutter
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true, // Labels dikhana hamesha achha hota hai
            showUnselectedLabels: true,
            onTap: controller.changeIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(IconsaxPlusBold.home_2), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(IconsaxPlusBold.bag_2), label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(IconsaxPlusBold.shopping_cart), label: 'Order'),
              BottomNavigationBarItem(icon: Icon(IconsaxPlusBold.wallet_2), label: 'Wallet'),
              BottomNavigationBarItem(icon: Icon(IconsaxPlusBold.profile), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}