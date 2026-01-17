import 'package:device_preview/device_preview.dart';
import 'package:ecommerce_app/BottomNav/main_layout.dart';
import 'package:ecommerce_app/CartPages/Cart_page.dart';
import 'package:ecommerce_app/HomePage/home_page.dart';
import 'package:ecommerce_app/WelcomePages/welcome.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    // enabled: false,
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
        home: MainLayout(),

    );
  }
}
