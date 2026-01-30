import 'package:ecommerce_app/modules/WalletPages/Top_Up_E-Wallet/top_up.dart';
import 'package:ecommerce_app/presentation/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wallet",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxPlusBroken.search_normal),
          ),

          IconButton(onPressed: (){}, icon: Icon(IconsaxPlusLinear.more_circle,size: 30,)),

          // const SizedBox(width: 16),
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
          //       (index) => Padding(
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
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Andrew Ainsley",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "**** **** **** **** 4321",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Text(
                          "VISA",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),

                        Column(
                          children: [
                            SizedBox(
                              width: 60, // 🔥 important (40 + 20 overlap)
                              height: 40,
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xfffa0202),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xcde8c908),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              "Mastercard",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        // const SizedBox(width: 5),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Your Balance",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "\$9,379",
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: TextButton.icon(
                            onPressed: () {
                              Get.to(TopUp());
                            },
                            icon: const Icon(
                              IconsaxPlusBroken.document_download,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Top Up",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 250, horizontal: 8),
            child: TransactionHistory(),
          ),
        ],
      ),
    );
  }
}

class TransactionHistory extends StatelessWidget {
  TransactionHistory({super.key});

  final WalletController controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                "Transaction History",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text("See All", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 16),

          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.transactionHistory.length,
                itemBuilder: (context, index) {
                  final item = controller.transactionHistory[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(item["Images"]),
                          radius: 25,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["description"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${item["date"]} | ${item["time"]}",
                              style: const TextStyle(color: Colors.grey),
                            ),

                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              "+\$${item["amount"]}",
                              style: const TextStyle(

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${item["status"]}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(
                                  PhosphorIconsFill.arrowSquareUp,
                                  color: Colors.red,
                                ),
                              ],
                            )
                          ],
                        )


                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
