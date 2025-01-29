import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});
  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: _customColor.customFAFAFA,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo/tever_outlined_logo.png",
            height: 80,
            width: 80,
          ),
          const SizedBox(height: 24),
          Text(
            "Nothing to see here yet",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: _customColor.custom4F4F4F,
            ),
          )
        ],
      ),
    );
  }
}
