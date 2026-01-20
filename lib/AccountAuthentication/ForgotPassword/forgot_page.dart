import 'package:ecommerce_app/AccountAuthentication/ForgotPassword/forgot_pss.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Forgot Password",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () {
              Get.to(() => const ForgotPss());
            },
            label: const Text(
              "Continue",
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

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(

              width: double.infinity,
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJI4kH0FxYV51mYHEGEFtfvVMr8KOjQqXL9mLzArKYHSvlTHeM",
                fit: BoxFit.cover,
                // height: 200,
              ),
            ),
            const SizedBox(height: 20,),
            const Text("Select which contact details should we use to reset your password", style: TextStyle(fontSize: 18,),),
            const SizedBox(height: 20,),

            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                // border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(


                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.email),
                    ),


                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Via Phone", style: TextStyle(fontSize: 16, color: Color(0xffcccaca)),),
                      const Text("+91 . . . . . .16", style: TextStyle(fontSize: 16),),
                    ],
                  )
                ],
              )
            ),
            const SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.email),
                    ),


                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Via Email", style: TextStyle(fontSize: 16, color: Color(
                          0xffcccaca)),),
                      const Text("kr...@gmail.com", style: TextStyle(fontSize: 16),),
                    ],
                  )
                ],
              )
            ),
            const SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
