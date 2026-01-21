import 'dart:developer';
import 'package:ecommerce_app/AccountAuthentication/LoginPage/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'LoginPage/Data_server/auth_service.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool isPasswordHidden = true;
  bool isLoading = false;
  bool isChecked = false;

  void handleRegister() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirm = confirmController.text.trim();

    if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
      showMessage("Please fill all fields");
      return;
    }

    if (password != confirm) {
      showMessage("Password not match");
      return;
    }

    setState(() => isLoading = true);

    final success = await AuthService.register(email, password);

    log(success.toString());

    if (success) {
      setState(() => isLoading = false);
      Get.offAll(() => const LoginPage());
      showMessage("Account created successfully ✅");

    } else {
      setState(() => isLoading = false);
      showMessage("Registration failed ❌");
    }
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(height: 50,),
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
                    isPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
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
