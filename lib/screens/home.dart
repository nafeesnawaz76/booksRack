import 'package:book/models/product_model.dart';
import 'package:book/screens/book_details.dart';
import 'package:book/widgets/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final imgList = [
    'assets/banner1.jpeg',
    'assets/awargi.jpg',
    'assets/dasht.jpg',
  ];

  final categories = [
    "All",
    "Islamic",
    "Fantasy",
    "Fiction",
    "Mystery",
    "Romantic",
    "Horror"
  ];

  late String selectedCategory;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    selectedCategory = categories[0];
    super.initState();
  }

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
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const Gap(5),
          TextFormField(
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
          const Text(
            "Categories",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
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
                          category,
                          style: TextStyle(
                            color: selectedCategory == category
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        backgroundColor: selectedCategory == category
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
                }),
          ),
          const Text(
            "Today's picks",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
            "New Arrivals",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 255,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                Product_model singleBook = allProducts[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookDetails()));
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 160,
                              width: 130,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Image.asset(
                                  singleBook.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Gap(5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 130,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      singleBook.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    singleBook.author,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Price: ${singleBook.price.toString()}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff5563AA),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Text(
            "All Products",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          GridView.builder(
            primary: false, //smooth scroll
            shrinkWrap: true, //unbounded height
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 3,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 0.7),
            scrollDirection: Axis.vertical,
            itemCount: allProducts.length,
            itemBuilder: (context, index) {
              Product_model singleProduct = allProducts[index];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 150,
                          width: 130,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Image.asset(
                              singleProduct.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const Gap(5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 160,
                            child: Text(
                              singleProduct.name,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            singleProduct.author,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Price: ${singleProduct.price.toString()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5563AA),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    ));
  }
}

List<Product_model> allProducts = [
  Product_model(
      id: "1",
      name: "Talash",
      image: "assets/talash.jpeg",
      isFavourite: false,
      price: 1400,
      description: "jab soch badlti hai to waqt badlta hai",
      status: "N/A",
      author: 'Arooba Amir'),
  Product_model(
      id: "2",
      name: "Sarab",
      image: "assets/sarab.png",
      isFavourite: false,
      price: 1200,
      description: "har chamakti chez sona nahi hoti",
      status: "N/A",
      author: 'Arooba Amir'),
  Product_model(
      id: "3",
      name: "Hum kahan k sachy thay",
      image: "assets/humKahankKSachyThay.jpeg",
      isFavourite: false,
      price: 900,
      description: "kitna azab hota hai kisi ka har waqt nazr ana",
      status: "N/A",
      author: 'Umera Ahmed'),
  Product_model(
      id: "4",
      name: "Namal",
      image: "assets/namal.jpeg",
      isFavourite: false,
      price: 700,
      description: "insano k bas main hifazat karna nahi hota",
      status: "N/A",
      author: 'Nimra Ahmed'),
  Product_model(
      id: "5",
      name: "Umeed",
      image: "assets/umeeed.jpeg",
      isFavourite: false,
      price: 1500,
      description: "jiski umeed Allah ho uski manzil kamyabi hai",
      status: "N/A",
      author: 'Arooba Amir'),
];
