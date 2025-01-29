import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class DeclinedRequest extends StatelessWidget {
  const DeclinedRequest({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(
          height: 40,
          width: double.infinity,
        ),
        Image.asset(
          "assets/icon/close_circle_bg_red.png",
          height: 56,
          width: 56,
        ),
        const SizedBox(height: 20),
        Text(
          "{Username} declined your request",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 8),
        Text(
          "You can start a new request or change payment method",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: _customColor.custom242424,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 40,
          width: 152,
          decoration: BoxDecoration(
              color: _customColor.customF9E8CC,
              borderRadius: BorderRadius.circular(100)),
          child: TextButton(
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
            onPressed: () {},
            child: Text(
              "New fund request",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
          width: double.infinity,
        ),
      ],
    );
  }
}
