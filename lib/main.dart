import 'package:device_preview/device_preview.dart';
import 'package:ecommerce_app/AccountAuthentication/AccountSetup/fill_your_profile.dart';
import 'package:ecommerce_app/AccountAuthentication/LoginPage/login_page.dart';
import 'package:ecommerce_app/WelcomePages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(
  DevicePreview(
    // enabled: !kReleaseMode,
    enabled: false,
    builder: (context) => MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: Welcome(),

    );
  }
}
