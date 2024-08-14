// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:book/screens/home.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Get.offAll(Home());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 180,
              width: Get
                  .width, //getx width of device ,add GetMaterialApp in main.dart page
              child: Lottie.asset("assets/splashlogo.json")),
          const Text(
            "BooksRack",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )
        ],
      ),
    ));
  }
}
