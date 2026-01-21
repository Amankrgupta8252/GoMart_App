import 'package:ecommerce_app/ProfilePages/Edit_All_Pages/address.dart';
import 'package:ecommerce_app/ProfilePages/Edit_All_Pages/edit_profile.dart';
import 'package:ecommerce_app/ProfilePages/Edit_All_Pages/payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:ecommerce_app/ProfilePages/Edit_All_Pages/notification_setting.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(IconsaxPlusLinear.more_circle,size: 30,)),

          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 20),

              // 🔥 Profile Image
              Center(
                child: CircleAvatar(
                  radius: 50,
                  // backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(
                      "https://th.bing.com/th/id/OIP.IGNf7GuQaCqz_RPq5wCkPgHaLH?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3",
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    "John Doe",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "johndoe@gmail.com",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),

              Divider(indent: 10, endIndent: 10),
              SizedBox(height: 20),

              Row(
                children: [
                  Icon(IconsaxPlusBold.user),
                  const SizedBox(width: 16),
                  Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.to(() => const EditProfile());
                    },
                    icon: Icon(Icons.navigate_next_outlined),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(IconsaxPlusBold.location),
                  const SizedBox(width: 16),
                  Text(
                    "Address",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.to(() => Address());
                    },
                    icon: Icon(Icons.navigate_next_outlined),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(IconsaxPlusBold.notification),
                  const SizedBox(width: 16),
                  Text(
                    "notification",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.to(() => NotificationSetting());
                    },
                    icon: Icon(Icons.navigate_next_outlined),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(IconsaxPlusBold.wallet_2),
                  const SizedBox(width: 16),
                  Text(
                    "Payment",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.to(() => Payment());
                    },
                    icon: Icon(Icons.navigate_next_outlined),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(IconsaxPlusBold.security),
                  const SizedBox(width: 16),
                  Text(
                    "Security",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // Get.to(() => Security());
                    },
                    icon: Icon(Icons.navigate_next_outlined),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(IconsaxPlusBold.language_circle),
                  const SizedBox(width: 16),
                  Text(
                    "Language",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text("English (US)", style: TextStyle(fontSize: 18)),
                  IconButton(
                    onPressed: () {
                      // Get.to(() => Security());
                    },
                    icon: Icon(Icons.navigate_next_outlined),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.dark_mode),
                  const SizedBox(width: 16),
                  Text(
                    "Dark Mode",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Switch(value: false, onChanged: (value) {}),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.lock),
                  const SizedBox(width: 16),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // Get.to(() => Security());
                    },
                    icon: Icon(Icons.navigate_next_outlined),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.question_mark_rounded),
                  const SizedBox(width: 16),
                  Text(
                    "Help Center",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // Get.to(() => Security());
                    },
                    icon: Icon(Icons.navigate_next_outlined),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(IconsaxPlusBold.share),
                  const SizedBox(width: 16),
                  Text(
                    "Invite Friends",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // Get.to(() => Security());
                    },
                    icon: Icon(Icons.navigate_next_outlined),
                  ),
                ],
              ),
              SizedBox(height: 8),

              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(IconsaxPlusBold.logout)),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
