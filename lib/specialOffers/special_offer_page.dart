import 'package:flutter/material.dart';

class SpecialOfferPage extends StatefulWidget {
  const SpecialOfferPage({super.key});

  @override
  State<SpecialOfferPage> createState() => _SpecialOfferPageState();
}

class _SpecialOfferPageState extends State<SpecialOfferPage> {
  // Controllers
  final PageController controller1 = PageController(viewportFraction: 0.98);
  final PageController controller2 = PageController(viewportFraction: 0.98);
  final PageController controller3 = PageController(viewportFraction: 0.98);
  final PageController controller4 = PageController(viewportFraction: 0.98);
  final PageController controller5 = PageController(viewportFraction: 0.98);
  final PageController controller6 = PageController(viewportFraction: 0.98);

  // Page index
  int page1 = 0;
  int page2 = 0;
  int page3 = 0;
  int page4 = 0;
  int page5 = 0;
  int page6 = 0;

  // Separate lists
  final List<String> offer1 = [
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
  ];

  final List<String> offer2 = [
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
  ];

  final List<String> offer3 = [
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
  ];
  final List<String> offer4 = [
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
  ];

  final List<String> offer5 = [
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
  ];

  final List<String> offer6 = [
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
    "assets/image/image_5.jpg",
  ];

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Special Offer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xff000000)),
            ),

            child: Row(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.all(2.50),
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            _offerSlider(
              images: offer1,
              controller: controller1,
              currentIndex: page1,
              onChanged: (index) {
                setState(() => page1 = index);
              },
            ),
            const SizedBox(height: 20),

            _offerSlider(
              images: offer2,
              controller: controller2,
              currentIndex: page2,
              onChanged: (index) {
                setState(() => page2 = index);
              },
            ),
            const SizedBox(height: 20),

            _offerSlider(
              images: offer3,
              controller: controller3,
              currentIndex: page3,
              onChanged: (index) {
                setState(() => page3 = index);
              },
            ),
            const SizedBox(height: 20),

            _offerSlider(
              images: offer4,
              controller: controller4,
              currentIndex: page4,
              onChanged: (index) {
                setState(() => page4 = index);
              },
            ),
            const SizedBox(height: 20),

            _offerSlider(
              images: offer5,
              controller: controller5,
              currentIndex: page5,
              onChanged: (index) {
                setState(() => page5 = index);
              },
            ),
            const SizedBox(height: 20),

            _offerSlider(
              images: offer6,
              controller: controller6,
              currentIndex: page6,
              onChanged: (index) {
                setState(() => page6 = index);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable slider widget
  Widget _offerSlider({
    required List<String> images,
    required PageController controller,
    required int currentIndex,
    required Function(int) onChanged,
  }) {
    return Stack(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: onChanged,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Dots indicator
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(images.length, (dotIndex) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: currentIndex == dotIndex ? 20 : 4,
                height: 4,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: currentIndex == dotIndex ? Colors.black : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
