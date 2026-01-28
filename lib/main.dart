import 'package:ecommerce_app/AccountAuthentication/signup_with.dart';
import 'package:ecommerce_app/Pages/main_layout.dart';
import 'package:ecommerce_app/WelcomePages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';


Future<String> getInitialRoute() async {
  final prefs = await SharedPreferences.getInstance();
  final seenWelcome = prefs.getBool("seenWelcome") ?? false;
  final user = FirebaseAuth.instance.currentUser;

  if (!seenWelcome) return "/welcome";
  if (user == null) return "/login";
  return "/home";
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getInitialRoute(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: snapshot.data!,
          getPages: [
            GetPage(name: "/welcome", page: () => const Welcome()),
            GetPage(name: "/login", page: () => const SignupWith()),
            GetPage(name: "/mainlayout", page: () => MainLayout()),
          ],
        );
      },
    );
  }
}
