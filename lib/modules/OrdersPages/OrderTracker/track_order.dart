import 'package:ecommerce_app/modules/OrdersPages/OrderTracker/tracking.dart';
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
          IconButton(onPressed: (){}, icon: const Icon(IconsaxPlusBroken.search_normal),),
          SizedBox(width: 10,)
        ],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                // height: 150,
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(

                    children: [

                      Expanded(
                        child: Container(

                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),

                          ),
                          child: Image.network("https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS4J5psHgg7ucQ-664XccsQAFWAzgds6D5Gm3KMALMFlSG5d-Er",fit: BoxFit.cover, width: double.infinity,),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Suga Leather Shoes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.brown
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text("Color"),
                              const SizedBox(width: 12),
                              const Text("|"),
                              const SizedBox(width: 12),
                              Text("Size: M"),
                              const SizedBox(width: 12),
                              const Text("|"),
                              const SizedBox(width: 12),
                              Text("Qty: 1"),
                            ],
                          ),
                          Text("\$375.00", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TrackBar(),
              ),
              const SizedBox(height: 20,),
              const Text("Packet In Delivery", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

              Divider(),
              
              SizedBox(height: 20,),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Order Status Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  const Tracking(),
                ],
              ),

              Divider(indent: 10, endIndent: 10,)
            ],
          ),
        ),
            
      )
    );
  }
}
