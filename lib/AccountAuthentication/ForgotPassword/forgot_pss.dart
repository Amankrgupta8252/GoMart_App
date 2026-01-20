import 'package:ecommerce_app/AccountAuthentication/AccountSetup/Finger_Print/fingerprint_page.dart';
import 'package:ecommerce_app/AccountAuthentication/ForgotPassword/new_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ForgotPss extends StatefulWidget {
  const ForgotPss({super.key});

  @override
  State<ForgotPss> createState() => _PinSetupState();
}

class _PinSetupState extends State<ForgotPss> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _pinCompleted(String pin) {
    debugPrint("Pin completed: $pin");

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("PIN set: $pin")));
  }

  @override
  Widget build(BuildContext context) {
    // Spacer();
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),



      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Forgot Password",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Code has been send to +91 ******16",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 50),

              Center(

                child: Pinput(
                  length: 4,
                  controller: _pinController,
                  defaultPinTheme: defaultPinTheme,

                  separatorBuilder: (index) => const SizedBox(width: 30),

                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue),
                    ),
                  ),
                  onCompleted: _pinCompleted,
                ),

              ),

              const SizedBox(height: 80),

              Text("Resend code in 55 s", style: TextStyle(fontSize: 20),),

              const SizedBox(height: 80),

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.to(() => NewPassword());
                    },
                    label: const Text(
                      "Verify",
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
      ),
    );
  }
}
