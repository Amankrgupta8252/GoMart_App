import 'package:ecommerce_app/AccountAuthentication/ForgotPassword/new_password.dart';
import 'package:ecommerce_app/AccountAuthentication/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ForgotPss extends StatefulWidget {
  final String userInput; // Piche se aane wala email/phone
  const ForgotPss({super.key, required this.userInput});

  @override
  State<ForgotPss> createState() => _ForgotPssState();
}

class _ForgotPssState extends State<ForgotPss> {
  final TextEditingController _pinController = TextEditingController();
  bool isPinComplete = false;
  bool isLoading = false;

  void handleVerify() async {
    setState(() => isLoading = true);

    // Firestore se OTP match karna
    bool isValid = await AuthService.verifyOTP(widget.userInput, _pinController.text);

    setState(() => isLoading = false);

    if (isValid) {
      Get.to(() => NewPassword(userInput: widget.userInput));
    } else {
      Get.snackbar("Error", "Invalid or Expired OTP", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 70, height: 70,
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(15)),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text("Verification Code", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Enter code sent to ${widget.userInput}", textAlign: TextAlign.center),
            const SizedBox(height: 50),
            Pinput(
              length: 4,
              controller: _pinController,
              defaultPinTheme: defaultPinTheme,
              onCompleted: (pin) => setState(() => isPinComplete = true),
              onChanged: (pin) => setState(() => isPinComplete = pin.length == 4),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: (isPinComplete && !isLoading) ? handleVerify : null,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                child: isLoading ? const CircularProgressIndicator() : const Text("Verify", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}