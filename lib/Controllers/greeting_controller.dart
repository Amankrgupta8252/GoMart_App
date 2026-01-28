import 'dart:async';
import 'package:get/get.dart';

class GreetingController extends GetxController {
  late Timer _timer;
  var greeting = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _updateGreeting();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateGreeting();
    });
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 3 && hour < 12) {
      greeting.value = "Good Morning 👋";
    } else if (hour >= 12 && hour < 15) {
      greeting.value = "Good Afternoon 👋";
    } else {
      greeting.value = "Good Evening 👋";
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
