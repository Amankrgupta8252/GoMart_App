import 'package:get/get.dart';

class WalletController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Map<String, dynamic>> transactionHistory = <Map<String, dynamic>>[
    {
      "date": "Dec 15, 2024",
      "time": "10:30 AM",
      "amount": 100,
      "type": "Suga Leather Shoes",
      "description": "Suga Leather Shoes",
      "status": "Order",
      "Images": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4J5psHgg7ucQ-664XccsQAFWAzgds6D5Gm3KMALMFlSG5d-Er"
    },

  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

}