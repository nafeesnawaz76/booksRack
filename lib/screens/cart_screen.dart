// ignore_for_file: must_be_immutable

import 'package:book/models/cart_model.dart';
import 'package:book/models/product_model.dart';
import 'package:book/screens/book_details.dart';
import 'package:book/screens/checkout_screen.dart';
import 'package:book/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  Productmodel? productModel;
  CartScreen({super.key, required this.productModel});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool value = false;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        leading: IconButton(
            onPressed: () {
              Get.off(() => BookDetails(productmodel: widget.productModel!));
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
      ),
      body: SizedBox(
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('cart')
              .doc(user!.uid)
              .collection("cartOrders")
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: Get.height / 5,
                child: const Center(child: LoadingScreen()),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("Your cart is empty"),
              );
            }

            if (snapshot.data != null) {
              return ListView.builder(
                primary: false, //smooth scroll
                shrinkWrap: true, //unbounded height

                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  CartModel cartmodel = CartModel(
                    categoryId: productData['categoryId'],
                    id: productData['id'],
                    name: productData['name'],
                    //categoryName: productData['categoryName'],
                    price: productData['price'],
                    images: productData['images'],
                    description: productData['description'],
                    author: productData['author'],
                    createdAt: productData["createdAt"],
                    updatedAt: productData["updatedAt"],
                    productQuantity: productData["productQuantity"],
                    productTotalPrice: productData["productTotalPrice"],
                  );
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          height: 100,
                          color: Colors.white,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      //Gap(10),
                                      Image(
                                        image: NetworkImage(
                                          cartmodel.images[0],
                                        ),
                                        height: 100,
                                        width: 60,
                                      ),
                                      const Gap(20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: Text(
                                              cartmodel.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          const Gap(5),
                                          Text(
                                            cartmodel.author,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 16),
                                          ),
                                          const Gap(5),
                                          Text(
                                            "Rs: ${cartmodel.productTotalPrice}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xff5563AA)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Checkbox(
                                          value: value,
                                          onChanged: (value) {
                                            setState(() {
                                              value = value;
                                            });
                                          }),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 14,
                                              backgroundColor:
                                                  Color(0xff5563AA),
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                            const Gap(8),
                                            Text(
                                              cartmodel.productQuantity
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            const Gap(8),
                                            const CircleAvatar(
                                              radius: 14,
                                              backgroundColor:
                                                  Color(0xff5563AA),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ));
                },
              );
            }
            return Container();
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 130,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Item selected",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                  Text(
                    "2",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Rs: 150",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(() => CheckoutScreen(
                        productModel: widget.productModel!,
                      ));
                },
                style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                    backgroundColor: const WidgetStatePropertyAll(
                      Color(0xff5563AA),
                    ),
                    minimumSize: const WidgetStatePropertyAll(
                        Size(double.infinity, 50))),
                child: const Text(
                  "Order now",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
