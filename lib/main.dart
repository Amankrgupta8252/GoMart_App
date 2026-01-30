import 'package:ecommerce_app/AccountAuthentication/signup_with.dart';
import 'package:ecommerce_app/WelcomePages/welcome.dart';
import 'package:ecommerce_app/modules/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'AccountAuthentication/services/local_storage.dart';
import 'firebase_options.dart';

Future<String> getInitialRoute() async {
  bool isFirstTime = LocalStorage.isFirstTime();
  bool isLoggedIn = LocalStorage.isLoggedIn();

  if (isFirstTime) {
    return "/welcome";
  } else if (isLoggedIn) {
    return "/mainlayout";
  } else {
    return "/login";
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getInitialRoute(),
      builder: (context, snapshot) {
        // Jab tak data load ho raha hai, Loading spinner dikhao
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Colors.black),
              ),
            ),
          );
        }

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // Snapshot se aane wala route use karein
          initialRoute: snapshot.data ?? "/login",
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
