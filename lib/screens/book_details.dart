import 'package:book/screens/auth/login_screen.dart';
import 'package:book/checkout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Talash',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark, size: 25),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Image.asset(
                    "assets/talash.jpeg",
                    opacity: const AlwaysStoppedAnimation(.2),
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 30,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.symmetric(horizontal: 85),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/talash.jpeg",
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Author: ",
                        style: TextStyle(
                            fontSize: 18, color: Color.fromARGB(255, 6, 6, 8)),
                      ),
                      Text(
                        "Arooba Amir",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff5563AA),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            " 4.5   ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 6, 6, 8)),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.black45,
                        height: 20,
                        width: 2,
                      ),
                      const Row(
                        children: [
                          Text(
                            "   pages",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            " 450   ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 6, 6, 8)),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.black45,
                        height: 20,
                        width: 2,
                      ),
                      const Row(
                        children: [
                          Text(
                            "   Language",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            " Urdu   ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 6, 6, 8)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 9, 10, 12),
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Umeed (Hope) by Arooba Mir is a captivating Urdu novel that delves into the depths of human resilience and the enduring power of hope. The story unfolds as a poignant exploration of life's challenges, where characters grapple with adversity and strive to find their way through darkness.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Rs 900",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
                  backgroundColor: const WidgetStatePropertyAll(
                    Color(0xff5563AA),
                  ),
                ),
                onPressed: () {
                  final user = FirebaseAuth
                      .instance.currentUser; // Check user authentication
                  if (user != null) {
                    // User is logged in
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.white70,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Product added successfully",
                              style: TextStyle(color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Checkout()),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xff5563AA),
                                    borderRadius: BorderRadius.circular(30)),
                                height: 30,
                                width: 100,
                                child: const Center(child: Text("check cart")),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    // User is not logged in
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.local_grocery_store_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Add to cart",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
