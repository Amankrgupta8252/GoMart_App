import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/AccountAuthentication/services/auth_service.dart';
import 'package:ecommerce_app/modules/ProfilePages/Edit_All_Pages/address.dart';
import 'package:ecommerce_app/modules/ProfilePages/Edit_All_Pages/edit_profile.dart';
import 'package:ecommerce_app/modules/ProfilePages/Edit_All_Pages/notification_setting.dart';
import 'package:ecommerce_app/modules/ProfilePages/Edit_All_Pages/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxPlusLinear.more_circle, size: 30),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserData(),
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          // 2. Error State
          if (snapshot.hasError ||
              !snapshot.hasData ||
              !snapshot.data!.exists) {
            return const Center(child: Text("Failed to load profile data"));
          }

          // 3. Data Ready
          final userData = snapshot.data!.data()!;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // 🔥 Profile Image
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: NetworkImage(
                            userData['photo'] ??
                                "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Name & Email
                  Text(
                    userData['name'] ?? "New User",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userData['email'] ?? "No Email Found",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Settings Options List
                  profileMenuItem(
                    IconsaxPlusBold.user,
                    "Edit Profile",
                    () => Get.to(() => const EditProfile()),
                  ),
                  profileMenuItem(
                    IconsaxPlusBold.location,
                    "Address",
                    () => Get.to(() => Address()),
                  ),
                  profileMenuItem(
                    IconsaxPlusBold.notification,
                    "Notification",
                    () => Get.to(() => const NotificationSetting()),
                  ),
                  profileMenuItem(
                    IconsaxPlusBold.wallet_2,
                    "Payment",
                    () => Get.to(() => const Payment()),
                  ),
                  profileMenuItem(IconsaxPlusBold.security, "Security", () {}),
                  profileMenuItem(
                    IconsaxPlusBold.language_circle,
                    "Language",
                    () {},
                    trailing: "English (US)",
                  ),

                  // Dark Mode Toggle
                  ListTile(
                    leading: const Icon(Icons.dark_mode),
                    title: const Text(
                      "Dark Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Switch(value: false, onChanged: (v) {}),
                  ),

                  profileMenuItem(Icons.lock_outline, "Privacy Policy", () {}),
                  profileMenuItem(Icons.help_outline, "Help Center", () {}),
                  profileMenuItem(
                    IconsaxPlusBold.share,
                    "Invite Friends",
                    () {},
                  ),

                  // 🚪 LOGOUT BUTTON
                  // ProfilePage.dart ke andar
                  ListTile(
                    onTap: () {
                      Get.dialog(
                        Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  "https://cdni.iconscout.com/illustration/premium/thumb/logged-out-illustration-svg-download-png-5639814.png",
                                  height: 100,
                                ),
                                const SizedBox(height: 20),

                                const Text(
                                  "Logout",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Are you sure you want to logout?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 30),

                                // 3. Big Logout Button
                                SizedBox(
                                  width: double.infinity,
                                  // Button ko bada karne ke liye
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: () async {
                                      await AuthService.logout();
                                    },
                                    child: const Text(
                                      "Yes, Logout",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // 4. Cancel Button
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    leading: const Icon(
                      IconsaxPlusBold.logout,
                      color: Colors.red,
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Common UI Widget for Menu Items
  Widget profileMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    String? trailing,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null)
            Text(
              trailing,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          const Icon(Icons.navigate_next),
        ],
      ),
    );
  }

  // Logout Confirmation Dialog
  // void showLogoutDialog(BuildContext context) {
  //   Get.defaultDialog(
  //     title: "Logout",
  //     middleText: "Are you sure you want to logout?",
  //     textCancel: "No",
  //     textConfirm: "Yes",
  //     confirmTextColor: Colors.white,
  //     buttonColor: Colors.black,
  //     onConfirm: () async {
  //       await AuthService.; // static function call
  //     },
  //   );
  // }
}
