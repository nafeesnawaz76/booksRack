// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, use_build_context_synchronously

import 'package:book/models/user_model.dart';
import 'package:book/screens/auth/login_screen.dart';
import 'package:book/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthFunctions {
  // ignore: prefer_final_fields

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Stream<User?> get getAuthChange => _auth
      .authStateChanges(); //so that if user login then exit app he stays login next time

//Login Function

  static Future<UserCredential?> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user!.emailVerified) {
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Email not verified,please verify your email",
              style: TextStyle(color: Color.fromARGB(255, 235, 236, 240)),
            ),
          ),
        );
      }
      return userCredential;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$Error")));
      return null;
    }
  }
  // Signup Function

  static Future<UserCredential?> signUp(
      String fullName,
      String email,
      String password,
      String userDeviceToken,
      String phoneNumber,
      String Address,
      BuildContext context //take these values from user by ui
      ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password); //create user

      await userCredential.user!
          .sendEmailVerification(); //user would not be null as registered above,sending email for verification

      UserModel userModel = UserModel(
          uId:
              userCredential.user!.uid, //when user us created given a unique id
          username: fullName,
          email: email,
          phone: phoneNumber,
          userImg: "",
          userDeviceToken: userDeviceToken, //for push notifications
          userAddress: Address,
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now());

      _firestore
          .collection(
              "users") //make a collection named users if already exists just go there
          .doc(userCredential.user!.uid) //assign a uniue id to document
          .set(userModel.toMap()); //save data of usermodel in map type

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Verification email sent,please check your mail inbox",
            style: TextStyle(color: Color.fromARGB(255, 235, 236, 240)),
          ),
        ),
      );

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));

      return userCredential; //if bool return true
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error:$e "),
      ));

      return null;
    }
  }

  static Future<void> resetPassword(String email, BuildContext context) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Recovery email sent to $email",
            style: const TextStyle(color: Color.fromARGB(255, 235, 236, 240)),
          ),
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }).onError((Error, StackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$Error"),
      ));
    });
  }

  static Future<void> logout(BuildContext context) async {
    await _auth.signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }
}
