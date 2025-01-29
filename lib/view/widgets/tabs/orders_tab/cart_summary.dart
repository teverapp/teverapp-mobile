import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  final CustomColors _customColor = const CustomColors();

  final List<String> _ratingPlaceHolder = const ["", "", "", ""];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "cart summary".toUpperCase(),
          style: TextStyle(
            fontFamily: "Anybody",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _customColor.custom242424,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Subtotal",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom292E2D),
            ),
            Text(
              "₦ 0,000",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom292E2D),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: _customColor.customDCDCDC,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text(
              "Proceed to Checkout",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
