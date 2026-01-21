import 'package:ecommerce_app/OrdersPages/completed_order.dart';
import 'package:ecommerce_app/OrdersPages/order_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class TopNav extends StatelessWidget {
  const TopNav({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            "My Orders",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(IconsaxPlusBroken.search_normal),
            ),
            // const SizedBox(width: 16),
            IconButton(onPressed: (){}, icon: Icon(IconsaxPlusLinear.more_circle,size: 30,)),

            // Container(
            //   width: 30,
            //   height: 30,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     border: Border.all(color: Colors.black),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: List.generate(
            //       3,
            //           (index) => Padding(
            //         padding: const EdgeInsets.all(2.5),
            //         child: Container(
            //           width: 4,
            //           height: 4,
            //           decoration: BoxDecoration(
            //             color: Colors.black,
            //             borderRadius: BorderRadius.circular(2),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(width: 16),
          ],

          /// ✅ TAB BAR INSIDE SAME APP BAR
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: TabBar(
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              indicatorColor: Colors.black,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,

              tabs: [
                Tab(text: 'Ongoing'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
        ),

        body: TabBarView(
          children: [
            OrderPage(),
            CompletedOrder(),
          ],
        ),
      ),
    );
  }
}
