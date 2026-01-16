import 'package:ecommerce_app/search/searchController/search_keyboard_controller.dart';
import 'package:ecommerce_app/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchKeybord extends StatelessWidget {
  SearchKeybord({super.key});

  final controller = Get.put(SearchKeyboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 SEARCH BAR
            TextField(
              readOnly: true,
              onTap: () {
                Get.to(() => SearchPage(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 400));
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  IconsaxPlusLinear.search_normal_1,
                  color: Color(0xffb9b9b9),
                ),
                suffixIcon: const Icon(
                  PhosphorIconsBold.slidersHorizontal,
                  color: Color(0xff0e0e0e),
                ),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 🕘 HEADER
            Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  if (controller.recentSearches.isNotEmpty)
                    GestureDetector(
                      onTap: controller.clearAll,
                      child: const Text(
                        'Clear All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            const Divider(),

            /// 📃 RECENT LIST
            Expanded(
              child: Obx(
                    () => controller.recentSearches.isEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/image/No_Result.png',
                      height: 180,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "No Recent Searches",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Search something and it will appear here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                )
                    : ListView.builder(
                  itemCount: controller.recentSearches.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.history),
                      title: Text(
                          controller.recentSearches[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () =>
                            controller.removeItem(index),
                      ),
                      onTap: () {
                        Get.to(() => SearchPage());
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
