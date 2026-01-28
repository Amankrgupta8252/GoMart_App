import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/image_slider_controller.dart';

class ImageWithButtonSlider extends StatelessWidget {
  const ImageWithButtonSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageSliderController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    controller.items[index]["image"]!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
              ),
            ),

            Container(
              width: double.infinity,
              height: 350,
              padding: const EdgeInsets.all(16),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.items[controller.currentPage.value]["title"]!,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    /// 🔵 INDICATOR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.items.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 8,
                          width: controller.currentPage.value == index ? 30 : 8,
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == index
                                ? Colors.black
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        fixedSize: const Size(300, 50),
                      ),
                      onPressed: controller.nextPage,
                      child: Text(
                        controller.items[controller
                            .currentPage
                            .value]["button"]!,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
