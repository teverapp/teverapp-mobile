import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class OnlinePayment extends StatelessWidget {
  const OnlinePayment({super.key});

  final CustomColors _customColor = const CustomColors();

  Widget _buildPaymentMethodCard(
      {required String image,
      required double imageHeight,
      required double imageWidth}) {
    return Row(
      children: [
        Image.asset(
          "assets/icon/radio_inactive_circular.png",
          height: 20,
          width: 20,
        ),
        const SizedBox(width: 16),
        Image.asset(
          "assets/image/$image",
          height: imageHeight,
          width: imageWidth,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _customColor.customFAFAFA),
      child: Column(
        children: [
          _buildPaymentMethodCard(
              image: "paystack.png", imageHeight: 15.5, imageWidth: 87),
          const SizedBox(height: 16),
          _buildPaymentMethodCard(
              image: "stripe.png", imageHeight: 22.5, imageWidth: 40),
        ],
      ),
    );
  }
}
