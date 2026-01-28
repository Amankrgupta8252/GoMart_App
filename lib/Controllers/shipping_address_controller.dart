import 'package:get/get.dart';

class ShippingAddressController extends GetxController {
  var selectedIndex = 0.obs;

  final addressList = [
    {"title": "Home", "address": "61480 Sunbrook Park, PC 5679"},
    {"title": "Office", "address": "210 Business Street, NY 10001"},
    {"title": "Apartment", "address": "45 Green Road, LA 90021"},
    {"title": "Parents House", "address": "78 Lake View, TX 73301"},
    {"title": "Other", "address": "12 Unknown Street, CA 90210"},
  ];

  void selectAddress(int index) {
    selectedIndex.value = index;
  }
}
