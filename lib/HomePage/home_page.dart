import 'package:ecommerce_app/HomePage/GreetingPage/greeting_page.dart';
import 'package:ecommerce_app/HomePage/SpecialOffersPage/special_offers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../lick_items/wish_list.dart';
import '../notification/notification_page.dart';
import '../search/search_keybord.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        
        child: Column(
          
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0x6ea5a5a5),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/image/Aman_1.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                       Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GreetingPage(),
                            Text(
                              'Aman Gupta',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationPage(),
                            ),
                          );
                        },
                        icon: const Icon(PhosphorIconsRegular.bell),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => WishList()),
                          );
                        },
                        icon: const Icon(IconsaxPlusLinear.heart),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Search Box
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF3F3F3),
                    ),
                    child: TextField(
                      readOnly: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(
                              milliseconds: 800,
                            ),
                            pageBuilder: (_, __, ___) => SearchKeybord(),
                          ),
                        );
                      },
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 2.1,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          IconsaxPlusLinear.search_normal_1,
                          color: Color(0xffb9b9b9),
                        ),
                        suffixIcon: Icon(PhosphorIconsBold.slidersHorizontal),
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Color(0xffb9b9b9)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),


            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(children: [SpecialOffers()]),
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: CustomBottomNav(),
    );

  }
}
