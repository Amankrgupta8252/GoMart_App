import 'package:ecommerce_app/AccountAuthentication/AccountSetup/fill_your_profile.dart';
import 'package:ecommerce_app/AccountAuthentication/ForgotPassword/forgot_page.dart';
import 'package:ecommerce_app/AccountAuthentication/ForgotPassword/forgot_pss.dart';
import 'package:ecommerce_app/HomePage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Data_server/auth_service.dart';

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

  void handleLogin() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showMessage("Please fill all fields");
      return;
    }

    final success = AuthService.login(email, password);

    if (success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FillYourProfile()));
      // showMessage("Login Successful ✅");
    } else {
      showMessage("Invalid Email or Password ❌");
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeybordOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            if (!isKeybordOpen)
              Column(
                children: const [
                  Text('Login to your Account',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
                ],
              ),

            SizedBox(height: 20,),
            /// EMAIL
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",

                prefixIcon: Icon(Icons.email),

                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// PASSWORD
            TextField(
              controller: passwordController,
              obscureText: isPasswordHidden,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: "Password",
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme(
                data: Theme.of(context).copyWith(
                checkboxTheme: CheckboxThemeData(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // 👈 radius
                  ),
                ),
              ),
              child: Checkbox(
              value: isChecked,
              activeColor: Colors.black, // ✔ checked color
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
          ),
          // const SizedBox(width: 6),
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
                    foregroundColor: Colors.white
                ),

                onPressed: handleLogin,
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),

              ),
            ),

            const SizedBox(height: 24),
            TextButton(onPressed: () {
              Get.to(() => const ForgotPage());
            }, child: Text("Forgot Password")),

          ],
        ),
      )
    );
  }
}
