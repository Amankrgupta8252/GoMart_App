import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/image/paypal.jpg",
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "PayPal",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const Text("Connected", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            SizedBox(height: 12,),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/image/google_pay.png",
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "Google Pay",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const Text("Connected", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                  },
                  label: const Text(
                    "Add New Payment",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(30),

                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
