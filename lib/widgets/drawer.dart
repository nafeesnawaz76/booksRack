// ignore_for_file: must_be_immutable

import 'package:book/screens/auth/login_screen.dart';
import 'package:book/screens/cart_screen.dart';
import 'package:book/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            height: 180,
            width: Get.width,
            color: const Color(0xff5563AA),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s"),
                  ),
                  Text(
                    "Ali",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "ali76@gmail.com",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                drawerTile(
                    text: 'My Cart',
                    icn: Icons.shopping_cart_outlined,
                    onpressed: () {
                      if (user == null) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Login Required"),
                              content: const Text("Please login to continue."),
                              actions: [
                                ElevatedButton(
                                  child: const Text("Login"),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Get.to(const CartScreen());
                      }
                    }),
                drawerTile(
                    text: 'Log Out',
                    icn: Icons.logout,
                    onpressed: () {
                      AuthFunctions.logout(context);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class drawerTile extends StatelessWidget {
  const drawerTile({
    super.key,
    required this.text,
    required this.icn,
    required this.onpressed,
  });
  final String text;
  final IconData icn;
  final Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icn,
            color: const Color(0xff5563AA),
          ),
          const SizedBox(
            width: 50,
          ),
          GestureDetector(
            onTap: onpressed,
            child: Text(
              text,
              style: const TextStyle(fontSize: 18, color: Color(0xff5563AA)),
            ),
          ),
        ],
      ),
    );
  }
}
