import 'package:ecommerce_app/Pages/CartPages/Cart_page.dart';
import 'package:ecommerce_app/Pages/HomePage/home_page.dart';
import 'package:ecommerce_app/Pages/OrdersPages/top_nav.dart';
import 'package:ecommerce_app/Pages/ProfilePages/profile_page.dart';
import 'package:ecommerce_app/Pages/WalletPages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../Controllers/bottom_nav_controller.dart';


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
              BottomNavigationBarItem(icon: Icon(PhosphorIconsFill.house), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.card_travel), label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Order'),
              BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}