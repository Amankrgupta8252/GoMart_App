import 'package:get/get.dart';

class OrderController extends GetxController {
  RxList<dynamic> orderItems = [].obs;

  /// CART ITEMS (Reactive)
  RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[
    {
      "Image":
      "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTVKOQFgmiOvX-p6gELSLfiAcSMum82xRe1vBn34o5nx403xNk3",
      "Name": "Werolla Cardigans",
      "Color": "0xff919090", // hex color
      "Size": "M",
      "Price": 340.0,
      "Qty": 1,

    },
    {
      "Image":
      "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTVKOQFgmiOvX-p6gELSLfiAcSMum82xRe1vBn34o5nx403xNk3",
      "Name": "Winter Hoodie",
      "Color": "0xff000000",
      "Size": "L",
      "Price": 499.0,
      "Qty": 1,
    },
  ].obs;

  /// INCREASE QUANTITY
  void increaseQty(int index) {
    cartItems[index]["Qty"]++;
    cartItems.refresh();
  }

  /// DECREASE QUANTITY
  void decreaseQty(int index) {
    if (cartItems[index]["Qty"] > 1) {
      cartItems[index]["Qty"]--;
      cartItems.refresh();
    }
  }

  /// REMOVE ITEM
  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  /// TOTAL PRICE
  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item["Price"] * item["Qty"];
    }
    return total;
  }
}
