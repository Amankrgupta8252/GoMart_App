import 'package:ecommerce_app/AccountAuthentication/AccountSetup/fill_your_profile.dart';
import 'package:ecommerce_app/AccountAuthentication/ForgotPassword/forgot_page.dart';
import 'package:ecommerce_app/modules/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../services/local_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;
  bool isChecked = false;

  void handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage("Please fill all fields");
      return;
    }

    final user = await AuthService.login(email, password);

    if (user != null) {
      LocalStorage.saveSession(email: user.email ?? "", method: "email");

      Get.offAll(() => MainLayout());
    } else {
      showMessage("Invalid Email or Password ❌");
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                'Login to your Account',
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isChecked,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Text(
                  'Remember me',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// LOGIN BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: handleLogin,
                child: const Text("Login", style: TextStyle(fontSize: 18)),
              ),
            ),

            const SizedBox(height: 24),

            TextButton(
              onPressed: () {
                Get.to(() => const ForgotPage());
              },
              child: const Text("Forgot Password"),
            ),
          ],
        ),
      ),
    );
  }
}
