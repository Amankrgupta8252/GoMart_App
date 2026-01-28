import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/presentation/pages/home/greeting_page.dart';
import 'package:ecommerce_app/presentation/pages/home/special_offers.dart';
import 'package:ecommerce_app/presentation/pages/wishlist/wish_list.dart';
import 'package:ecommerce_app/presentation/pages/notifications/notification_page.dart';
import 'package:ecommerce_app/presentation/pages/search/search_keybord.dart';
import 'package:ecommerce_app/presentation/widgets/shimmers/app_shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';


Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception("User not logged in");
  }

  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid) // 👈 ONLY logged-in user
      .get();
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppShimmer.homeShimmer(); // 👈 YAHI use hota hai shimmer
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("User data not found"));
          }

          final userData = snapshot.data!.data()!;

          return SafeArea(
            top: false,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(userData['photo'].toString()),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GreetingPage(),
                            Text(
                              userData['name'].toString(),
                              style: const TextStyle(
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
                ),
                SizedBox(height: 5,),

                /////////////////////////////////  Search box    //////////////////////////////////

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF3F3F3),
                    ),
                    child: TextField(
                      readOnly: true,
                      onTap: () {
                        Get.off( SearchKeybord());
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
                ),

                /////////////////////////////////  Special Offers    //////////////////////////////////

                Expanded(child: SpecialOffers()),
              ],
            ),
          );
        },
      ),

    );
  }



}
