import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class ScanToPayCard extends StatelessWidget {
  const ScanToPayCard({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Scan to pay",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        Text(
          "Scan QR code of the seller or at the store to pay",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: _customColor.custom5D5D5D),
        ),
        Container(
          color: _customColor.customFDF7ED,
          margin: const EdgeInsets.symmetric(vertical: 24),
          width: double.infinity,
          alignment: Alignment.center,
          height: 200,
          child: Image.asset(
            "assets/icon/scan_orange.png",
            height: 120,
            width: 120,
          ),
        )
      ],
    );
  }
}
