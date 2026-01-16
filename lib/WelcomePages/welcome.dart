import 'dart:async';

import 'package:ecommerce_app/WelcomePages/WelcomeNext/ImageWithButtonSlider.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  void initState() {
    super.initState();

    // ⏳ 3 seconds delay then navigate
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ImageWithButtonSlider()),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/image/team-5-min-1.jpeg'),
            fit: BoxFit.cover,

          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
          child: Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 255 * 0.9)
              ],
                stops: [
                  0.5,
                  0.8
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Text('Welcome to 👋',style: TextStyle(color: Colors.white, fontSize: 40),),
                    ],
                  ),

                  Text('Aman',style: TextStyle(color: Colors.white, fontSize: 80, fontWeight: FontWeight.bold),),
                  Text('The best e-commerce app of the century for your daily needs!',style: TextStyle(color: Colors.white, fontSize: 18),),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
