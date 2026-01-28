import 'package:ecommerce_app/presentation/controllers/greeting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GreetingPage extends StatelessWidget {
  GreetingPage({super.key});

  final GreetingController controller =
  Get.put(GreetingController());

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Text(
        controller.greeting.value,
        style: const TextStyle(
          color: Color(0xcf919159),
        ),
      ),
    );
  }
}
