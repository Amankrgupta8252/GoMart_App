import 'package:ecommerce_app/AccountAuthentication/LoginPage/login_page.dart';
import 'package:ecommerce_app/AccountAuthentication/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  void handleReset() async {
    String email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar("Error", "Please enter a valid email", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    setState(() => isLoading = true);

    // Firebase Auth Reset Email Logic
    bool success = await AuthService.sendPasswordReset(email);

    setState(() => isLoading = false);

    if (success) {
      Get.defaultDialog(
        title: "Check Your Email",
        middleText: "A password reset link has been sent to $email. Please follow the link to change your password.",
        textConfirm: "Back to Login",
        confirmTextColor: Colors.white,
        buttonColor: Colors.black,
        onConfirm: () => Get.offAll(() => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password", style: TextStyle(fontWeight: FontWeight.bold))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity, height: 55,
          child: ElevatedButton(
            onPressed: isLoading ? null : handleReset,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
            child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Send Reset Link", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJI4kH0FxYV51mYHEGEFtfvVMr8KOjQqXL9mLzArKYHSvlTHeM", height: 200),
            const SizedBox(height: 30),
            const Text("Enter your email and we'll send you a link to reset your password.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 30),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter Email Address",
                prefixIcon: const Icon(Icons.email_outlined),
                filled: true, fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}