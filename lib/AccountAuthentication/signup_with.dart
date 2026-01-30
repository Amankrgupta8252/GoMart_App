import 'package:ecommerce_app/AccountAuthentication/LoginPage/login_page.dart';
import 'package:ecommerce_app/AccountAuthentication/services/local_storage.dart';
import 'package:ecommerce_app/AccountAuthentication/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_service.dart';

class SignupWith extends StatelessWidget {
  const SignupWith({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(
                  "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQzFqT8rHedaZe-GK-e6H004W7IsuU3FHK8zE8VUr2Fg2zzaPI9",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Let's you in",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: socialButton(
                  text: "Continue with Google",
                  image:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/500px-Google_%22G%22_logo.svg.png",
                  onTap: () async {
                    final user = await auth.googleSignIn();

                    if (user != null) {
                      LocalStorage.saveSession(
                        email: user.email ?? "",
                        method: "google",
                      );
                      Get.offAllNamed('/mainlayout');
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: socialButton(
                  text: "Continue with Facebook",
                  image:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJnrq3V01lH2NfWrH8aRDp9OUJupGWBRk6jA&s",
                  onTap: () async {
                    await auth.facebookSignIn();
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: socialButton(
                  text: "Continue with Apple",
                  image:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCvh-j7HsTHJ8ZckknAoiZMx9VcFmsFkv72g&s",
                  onTap: () {
                    // iOS only
                  },
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "or",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Get.to(LoginPage());
                    },
                    child: const Text(
                      "Sign in with password",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(SignupPage());
                    },
                    child: Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialButton({
    required String text,
    required String image,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(image, width: 30),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
