// // ignore_for_file: must_be_immutable

// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:book/models/product_model.dart';
// import 'package:book/screens/cart_screen.dart';
// import 'package:book/screens/checkout_screen.dart';
// import 'package:book/screens/home.dart';
// import 'package:book/screens/profile_screen.dart';
// import 'package:flutter/material.dart';

// class BottomNav extends StatefulWidget {
//   Productmodel productModel;
//   BottomNav({super.key, required this.productModel});

//   @override
//   State<BottomNav> createState() => _HomeState();
// }

// class _HomeState extends State<BottomNav> {
//   List<IconData> iconList = [
//     Icons.home,
//     Icons.shopping_cart_outlined,
//     Icons.payment,
//     Icons.star,
//   ];

//   int page = 0;

//   int pageView = 0;

//   final PageController _pageController = PageController(initialPage: 0);

//   Widget pageViewSection() {
//     return PageView(
//       controller: _pageController,
//       onPageChanged: (value) {
//         setState(() {
//           page = value;
//         });
//       },
//       children: [
//         const Home(),
//         CartScreen(
//           productModel: widget.productModel,
//         ),
//         CheckoutScreen(
//           productModel: widget.productModel,
//         ),
//         const Wishlist()
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pageViewSection(),
//       bottomNavigationBar: AnimatedBottomNavigationBar(
//         backgroundColor: const Color(0xff5563AA),
//         gapLocation: GapLocation.none,
//         activeColor: Colors.white,
//         splashSpeedInMilliseconds: 300,
//         notchSmoothness: NotchSmoothness.smoothEdge,
//         leftCornerRadius: 10,
//         rightCornerRadius: 10,
//         icons: iconList,
//         activeIndex: page,
//         onTap: (p0) {
//           pageView = p0;
//           _pageController.animateToPage(p0,
//               curve: Curves.linear,
//               duration: const Duration(milliseconds: 300));
//         },
//       ),
//     );
//   }
// }
