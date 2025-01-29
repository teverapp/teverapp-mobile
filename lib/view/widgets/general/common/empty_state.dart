import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class EmptyState extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String buttonText;
  const EmptyState(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.buttonText});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 498,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 140,
            width: 140,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontFamily: "Anybody",
                fontWeight: FontWeight.w600,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 8),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 81),
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
