// ignore_for_file: unused_import

import 'package:book/models/categories_model.dart';
import 'package:book/models/product_model.dart';
import 'package:book/screens/book_details.dart';
import 'package:book/screens/loading.dart';
import 'package:book/widgets/categories.dart';
import 'package:book/widgets/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final imgList = [
    'assets/banner1.jpeg',
    'assets/awargi.jpg',
    'assets/dasht.jpg',
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();
  DocumentSnapshot? selectedCategory;

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance.collection('categories').get().then((snapshot) {
  //     if (snapshot.docs.isNotEmpty) {
  //       selectedCategory = snapshot.docs[0];
  //     }
  //   });
  // }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 35,
          ),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff5563AA),
        title: const Text(
          "BooksRack",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        elevation: 2,
        shadowColor: Colors.black,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        actions: const [
          CircleAvatar(
            radius: 25,
            foregroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi8LeJa7ZpHPegIo-vuhZhjVon4Kcl1rht9w&s"),
          ),
          Gap(10),
        ],
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const Gap(5),
          TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.search),
              hintText: "Search for a book",
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff5563AA)),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const Gap(5),
          CarouselSlider.builder(
            itemCount: imgList.length,
            itemBuilder: (context, index, realIndex) {
              final images = imgList[index];
              return Card(
                elevation: 5,
                child: Image.asset(
                  images,
                  fit: BoxFit.fill,
                ),
              );
            },
            options: CarouselOptions(
              height: 200,

              autoPlay: true,
              //reverse: true,
              //viewportFraction: 1,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              //autoPlayInterval: const Duration(seconds: 3),
            ),
          ),
          const Gap(5),
          const Text(
            "Categories",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('categories').get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 50,
                  child: Center(
                    child: LoadingScreen(),
                  ),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No category found!"),
                );
              }

              if (snapshot.data != null) {
                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length +
                        1, // Add 1 for the "All" chip
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // The "All" chip
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory =
                                    null; // or DocumentSnapshot(id: 'All')
                              });
                            },
                            child: Chip(
                              label: Text(
                                "All",
                                style: TextStyle(
                                  color: selectedCategory == null
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              backgroundColor: selectedCategory == null
                                  ? const Color(0xff5563AA)
                                  : Colors.white,
                              side: const BorderSide(color: Color(0xff5563AA)),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        final category = snapshot.data!.docs[
                            index - 1]; // Subtract 1 because of the "All" chip
                        CategoriesModel categoriesModel = CategoriesModel(
                          categoryId: snapshot.data!.docs[index - 1]
                              ['categoryId'],
                          categoryName: snapshot.data!.docs[index - 1]['title'],
                        );
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            child: Chip(
                              label: Text(
                                categoriesModel.categoryName,
                                style: TextStyle(
                                  color: selectedCategory?.id == category.id
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              backgroundColor:
                                  selectedCategory?.id == category.id
                                      ? const Color(0xff5563AA)
                                      : Colors.white,
                              side: const BorderSide(color: Color(0xff5563AA)),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                );
              }

              return Container();
            },
          ),
          const Gap(5),
          const Text(
            "Availabe Products",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          FutureBuilder(
              future: selectedCategory != null
                  ? FirebaseFirestore.instance
                      .collection('products')
                      .where('categoryId', isEqualTo: selectedCategory?.id)
                      .get()
                  : FirebaseFirestore.instance.collection('products').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: Get.height / 5,
                    child: Center(child: LoadingScreen()),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No products availables"),
                  );
                }

                if (snapshot.data != null) {
                  return GridView.builder(
                      primary: false, //smooth scroll
                      shrinkWrap: true, //unbounded height
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              childAspectRatio: 0.6),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final productData = snapshot.data!.docs[index];
                        Productmodel productModel = Productmodel(
                          categoryId: productData['categoryId'],
                          id: productData['id'],
                          name: productData['name'],
                          //categoryName: productData['categoryName'],
                          price: productData['price'],
                          image: productData['image'],
                          description: productData['description'],
                          isFavourite: productData['isFavourite'],
                          status: productData['status'],
                          author: productData['author'],
                        );
                        return GestureDetector(
                          onTap: () {
                            Get.offAll(() => BookDetails(
                                  productmodel: productModel,
                                ));
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 170,
                                    width: 140,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          productModel.image[0].toString(),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(5),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 160,
                                        child: Text(
                                          productModel.name,
                                          //overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Color(0xff5563AA),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        productModel.author,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "Rs: ${productModel.price.toString()}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
                return Container();
              })
        ]),
      ),
    ));
  }
}
