import 'dart:developer';
import 'package:ecommerce_app/AccountAuthentication/AccountSetup/fill_your_profile.dart';
import 'package:ecommerce_app/AccountAuthentication/LoginPage/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/auth_service.dart';
import 'services/local_storage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool isPasswordHidden = true;
  bool isLoading = false;
  bool isChecked = false;

  // SignupPage.dart ke andar

  void handleRegister() async {
    // 1. Inputs ko trim karke variables mein lena
    // final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmController.text.trim();

    // 2. Validation Checks
    // if (name.isEmpty || email.isEmpty || password.isEmpty) {
    //   showMessage("Please fill all fields ⚠️");
    //   return;
    // }

    if (password != confirmPassword) {
      showMessage("Passwords do not match ❌");
      return;
    }

    if (password.length < 6) {
      showMessage("Password must be at least 6 characters 🔐");
      return;
    }

    if (!isChecked) {
      showMessage("Please agree to the Terms & Conditions 📄");
      return;
    }

    // 3. Loading Start
    setState(() => isLoading = true);

    try {
      // 4. AuthService se Firebase mein register karna
      // Note: Ensure karein ki AuthService.register 'User?' return kare
      final user = await AuthService.register(email, password);

      if (user != null) {
        // 5. Session ko LocalStorage mein save karna (Persistence ke liye)
        LocalStorage.saveSession(
            email: user.email ?? email,
            method: "email"
        );

        setState(() => isLoading = false);

        // 6. Navigation: Registration ke baad seedha Fill Profile page par
        Get.offAll(() => const FillYourProfile());

        // Success Message
        Get.snackbar(
          "Success ✅",
          "Account created! Please complete your profile.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // Agar user null aaya (Registration fail hua)
        setState(() => isLoading = false);
        showMessage("Registration failed. Email might already be in use. ❌");
      }
    } catch (e) {
      setState(() => isLoading = false);
      showMessage("An error occurred: $e");
    }
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            if (!isKeyboardOpen)
              const Text(
                'Create your Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                // textAlign: TextAlign.center,
              ),

            const SizedBox(height: 30),

            /// EMAIL
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// PASSWORD
            TextField(
              controller: passwordController,
              obscureText: isPasswordHidden,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                labelText: "Password",
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// CONFIRM PASSWORD
            TextField(
              controller: confirmController,
              obscureText: isPasswordHidden,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isChecked,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() => isChecked = value!);
                  },
                ),
                const Text(
                  'I agree to Terms & Conditions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// REGISTER BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: isLoading ? null : handleRegister,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Register", style: TextStyle(fontSize: 18)),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () => Get.to(() => const LoginPage()),
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
