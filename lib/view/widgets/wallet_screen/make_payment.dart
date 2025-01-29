import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_screen/transaction.dart';

class MakePayment extends StatelessWidget {
  const MakePayment({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Make payment to...",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _customColor.custom242424,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 42,
          alignment: Alignment.centerLeft,
          color: _customColor.customE5F0F9,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Business/ seller/ brand name",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: _customColor.custom242424,
            ),
          ),
        ),
        Transaction(),
      ],
    );
  }
}
