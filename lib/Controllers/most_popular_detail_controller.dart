import 'package:get/get.dart';

class MostPopularDetailController extends GetxController {
  var selectedSizeIndex = 0.obs;
  var selectedColorIndex = 0.obs;
  var quantity = 1.obs;

  void changeSize(int index) => selectedSizeIndex.value = index;
  void changeColor(int index) => selectedColorIndex.value = index;

  void increment() => quantity.value++;
  void decrement() {
    if (quantity.value > 1) quantity.value--;
  }
}