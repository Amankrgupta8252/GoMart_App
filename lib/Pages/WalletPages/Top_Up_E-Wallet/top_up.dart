import 'package:flutter/material.dart';

class TopUp extends StatelessWidget {
  TopUp({super.key});

  final List<int> amount = [10, 20, 50, 100, 200, 500, 1000, 2000, 5000];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Top Up E-Wallet",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                "Enter the amount of top up",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            /// Amount display
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  "\$500",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// Amount buttons
            Wrap(
              spacing: 25,
              runSpacing: 12,
              children: List.generate(
                amount.length,
                    (index) {
                  return Container(
                    width: 100,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      "\$${amount[index]}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(onPressed: () {}, child: Text("Continue", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),), style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),),
            )
          ],
        ),
      ),
    );
  }
}
