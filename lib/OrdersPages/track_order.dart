import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Track Order"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(IconsaxPlusBroken.search_normal),)
        ],

      ),
      body: const Center(
        child: Text("Track Order", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
