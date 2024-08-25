import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProductsPrice extends GetxController {
  static RxDouble totalPrice = 0.0.obs;
  static User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    fetchProductPrice();
    super.onInit();
  }

  static void fetchProductPrice() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('cart')
        .doc(user!.uid)
        .collection('cartOrders')
        .get();

    double sum = 0.0;

    for (final doc in snapshot.docs) {
      final data = doc.data();
      if (data != null && data.containsKey('productTotalPrice')) {
        sum += (data['productTotalPrice'] as num).toDouble();
      }
    }

    totalPrice.value = sum;
  }
}
