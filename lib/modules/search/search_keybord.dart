import 'package:ecommerce_app/presentation/controllers/search_keyboard_controller.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 8,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            // readOnly: true,
            // onTap: () {
            //   Get.to(() => SearchPage(),
            //       transition: Transition.circularReveal,
            //       duration: const Duration(seconds: 1));
            // },
            decoration: InputDecoration(
              prefixIcon: const Icon(
                IconsaxPlusLinear.search_normal_1,
                color: Color(0xffb9b9b9),
              ),
              suffixIcon: const Icon(
                PhosphorIconsBold.slidersHorizontal,
                color: Color(0xffb9b9b9),
              ),
              hintText: 'Search for products...',
              hintStyle: const TextStyle(color: Color(0xffb9b9b9)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFFF3F3F3),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔍 SEARCH BAR
        
        
              const SizedBox(height: 30),
        
              /// 🔥 RECENT SEARCHES
              const Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              const SizedBox(height: 16),
        
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _searchChip('Summer Collection'),
                  _searchChip('Nike Shoes'),
                  _searchChip('Winter Wear'),
                  _searchChip('Accessories'),
                  _searchChip('Electronics'),
                ],
              ),
        
              const SizedBox(height: 30),
        
              /// 🌟 TRENDING NOW
              const Text(
                'Trending Now',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              const SizedBox(height: 16),
        
              Column(
                children: [
                  _trendingItem('1', 'Sports Shoes', '2.3k searches'),
                  _trendingItem('2', 'Summer Dresses', '1.8k searches'),
                  _trendingItem('3', 'Smart Watches', '1.5k searches'),
                  _trendingItem('4', 'Backpacks', '1.2k searches'),
                  _trendingItem('5', 'Sunglasses', '987 searches'),
                ],
              ),
        
              const SizedBox(height: 30),
        
              /// 📱 CATEGORIES
              const Text(
                'Browse Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              const SizedBox(height: 16),
        
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.5,
                children: [
                  _categoryCard('Clothing', PhosphorIconsBold.tShirt, Colors.blue),
                  _categoryCard('Shoes', PhosphorIconsBold.sneakerMove, Colors.green),
                  _categoryCard('Accessories', PhosphorIconsBold.watch, Colors.orange),
                  _categoryCard('Electronics', PhosphorIconsBold.devices, Colors.purple),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _trendingItem(String rank, String item, String searches) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            rank,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              item,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            searches,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryCard(String title, IconData icon, Color color) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: double.infinity,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
            ),
            child: Icon(icon, color: color),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
