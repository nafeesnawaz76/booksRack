// ignore_for_file: avoid_print

import 'package:book/services/stripeservices.dart';
import 'package:book/widgets/textfield.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Checkout> {
  final _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CustomTextFormField(
                hintText: "add amount",
                icon: Icons.attach_money_rounded,
                controller: _amountController,
                fieldname: "amount"),
            GestureDetector(
              onTap: () async {
                StripeService.instance
                    .makePayment(int.parse(_amountController.text));
              },
              child: const Text("Pay"),
            ),
          ],
        ),
      ),
    );
  }
}
