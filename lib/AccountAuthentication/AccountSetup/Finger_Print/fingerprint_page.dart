import 'package:ecommerce_app/modules/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintPage extends StatefulWidget {
  const FingerprintPage({super.key});

  @override
  State<FingerprintPage> createState() => _FingerprintPageState();
}

class _FingerprintPageState extends State<FingerprintPage> {
  final LocalAuthentication auth = LocalAuthentication();
  String error = "";

  Future<void> authenticate() async {
    try {
      final bool isSupported = await auth.isDeviceSupported();
      final bool canCheck = await auth.canCheckBiometrics;

      if (!isSupported || !canCheck) {
        setState(() {
          error = "This device does not support fingerprint";
        });
        return;
      }

      bool success = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        biometricOnly: true,
        // stickyAuth: true,
      );

      if (success) {
        Get.offAll(() => MainLayout());
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Set Your Fingerprint",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Text(
              "Add a fingerprint to make your account more secure.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 100),

            const Icon(Icons.fingerprint, size: 180),

            const SizedBox(height: 100),

            const Text(
              "Please put your finger on the fingerprint scanner to get started.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(

                    onPressed: () => Get.offAll(() => MainLayout()),
                    child: const Text("Skip"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: authenticate,
                    child: const Text("Continue"),
                  ),

                ),
              ],
            ),

            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
