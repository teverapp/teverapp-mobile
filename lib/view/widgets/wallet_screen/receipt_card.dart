import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class ReceiptCard extends StatelessWidget {
  final String label;
  final String value;
  final bool boldValue;
  const ReceiptCard(
      {super.key,
      required this.label,
      required this.value,
      this.boldValue = false});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: _customColor.customEFEFEF,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424),
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: !boldValue ? 14 : 16,
                fontWeight: !boldValue ? FontWeight.w400 : FontWeight.w600,
                color: _customColor.custom242424),
          )
        ],
      ),
    );
  }
}
