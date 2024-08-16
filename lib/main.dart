// ignore_for_file: unused_import

import 'package:book/firebase_options.dart';
import 'package:book/screens/cart_screen.dart';
import 'package:book/screens/home.dart';
import 'package:book/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51PlnlVRqIP0WBM7b7kMlKf6LXorxPB5nq9Sd1bRdzJI1MrZ37tuwHqH4yDuZslvXGi117GHkCSFf3XPIYMfHTjUs00ujHvZMaI";
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    // ignore: avoid_print
    print('Error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(fontFamily: "Lato", useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const CartScreen());
  }
}
