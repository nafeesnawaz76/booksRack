// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:book/screens/auth/login_screen.dart';
import 'package:book/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthFunctions {
  // ignore: prefer_final_fields
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<User?> get getAuthChange => _auth
      .authStateChanges(); //so that if user login then exit app he stays login next time

  static Future<void> login(
      String email, String password, BuildContext context) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "login Success",
            style: TextStyle(color: Color.fromARGB(255, 235, 236, 240)),
          ),
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }).onError((Error, StackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$Error"),
      ));
    });
  }

  static Future<void> signUp(
      String email, String password, BuildContext context) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "User Registered Successfully",
            style: TextStyle(color: Color.fromARGB(255, 235, 236, 240)),
          ),
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }).onError((Error, StackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$Error"),
      ));
    });
  }

  static Future<void> resetPassword(String email, BuildContext context) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Recovery email sent successfully",
            style: TextStyle(color: Color.fromARGB(255, 235, 236, 240)),
          ),
        ),
      );
    }).onError((Error, StackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$Error"),
      ));
    });
  }

  static Future<void> logout(BuildContext context) async {
    await _auth.signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }
}
