import 'package:ecommerce_app/CartPages/Cart_page.dart';
import 'package:ecommerce_app/HomePage/home_page.dart';
import 'package:ecommerce_app/OrdersPages/top_nav.dart';
import 'package:ecommerce_app/ProfilePages/profile_page.dart';
import 'package:ecommerce_app/WalletPages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'bottom_nav_controller.dart';


class MainLayout extends StatelessWidget {
  MainLayout({super.key});

  final BottomNavController controller =
  Get.put(BottomNavController(), permanent: true);

  final pages = [
    HomePage(),
    CartPage(),
    TopNav(),
    WalletPage(),
    ProfilePage()
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

      /// Bottom Navigation Bar
      bottomNavigationBar: Obx(
            () => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
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
            onTap: controller.changeIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(PhosphorIconsFill.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_travel),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'Wallet',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
