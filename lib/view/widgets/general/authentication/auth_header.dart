import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;

  final String subTitle;

  const AuthHeader({super.key, required this.title, required this.subTitle});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              title,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Anybody",
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 9),
            Text(
              subTitle,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom5D5D5D),
            ),
            const SizedBox(height: 24),
          ],
        ));
  }
}
