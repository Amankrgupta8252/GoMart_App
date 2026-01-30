import 'package:ecommerce_app/AccountAuthentication/LoginPage/login_page.dart';
import 'package:ecommerce_app/AccountAuthentication/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPassword extends StatefulWidget {
  final String userInput;
  const NewPassword({super.key, required this.userInput});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _passController = TextEditingController();
  final _confirmController = TextEditingController();
  bool hidePassword = true;
  bool isLoading = false;

  void updatePassword() async {
    if (_passController.text != _confirmController.text) {
      Get.snackbar("Error", "Passwords do not match", backgroundColor: Colors.red);
      return;
    }

    setState(() => isLoading = true);

    // Firestore mein password update karna
    await AuthService.updatePasswordInFirestore(widget.userInput, _passController.text);

    setState(() => isLoading = false);

    Get.defaultDialog(
      title: "Success",
      middleText: "Password updated! Please login with your new password.",
      onConfirm: () => Get.offAll(() => const LoginPage()),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Password")),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: isLoading ? null : updatePassword,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
            child: isLoading ? const CircularProgressIndicator() : const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network("https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSH3MQJBEc9tOs3EeNr7YZ-vVNKtYfyAIDylg7LlXIET6BMgBrn", height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _passController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: "New Password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => hidePassword = !hidePassword)),
                filled: true, fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: const Icon(Icons.lock),
                filled: true, fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}