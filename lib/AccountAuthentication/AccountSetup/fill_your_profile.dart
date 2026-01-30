import 'package:ecommerce_app/AccountAuthentication/AccountSetup/pin_setup.dart';
import 'package:ecommerce_app/AccountAuthentication/services/auth_service.dart'; // Apna path check karein
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class FillYourProfile extends StatefulWidget {
  const FillYourProfile({super.key});

  @override
  State<FillYourProfile> createState() => _FillYourProfileState();
}

class _FillYourProfileState extends State<FillYourProfile> {
  // Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill name if user already has one from Registration/Social Login
    nameController.text = FirebaseAuth.instance.currentUser?.displayName ?? "";
  }

  void saveProfileData() async {
    setState(() => isLoading = true);

    bool success = await AuthService.updateUserProfile(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      dob: dobController.text.trim(),
      gender: genderController.text.trim(),
    );

    setState(() => isLoading = false);

    if (success) {
      Get.to(() => const PinSetup());
    } else {
      Get.snackbar("Error", "Something went wrong while saving data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fill Your Profile", style: TextStyle(fontWeight: FontWeight.bold))),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: isLoading ? null : saveProfileData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Continue", style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // TextFields
            customTextField(nameController, "Full Name", IconsaxPlusBold.user),
            customTextField(phoneController, "Phone Number", Icons.phone),
            customTextField(addressController, "Address", IconsaxPlusBold.location),
            customTextField(dobController, "Date of Birth", Icons.date_range),
            customTextField(genderController, "Gender", Icons.man),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget customTextField(TextEditingController controller, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: const Color(0xffeae8e8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}