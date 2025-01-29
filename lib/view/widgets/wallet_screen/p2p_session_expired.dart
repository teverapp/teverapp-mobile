import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/rotate_image.dart';

class P2pSessionExpired extends StatelessWidget {
  const P2pSessionExpired({super.key});

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
          "assets/icon/alert_triangle.png",
          height: 64,
          width: 64,
        ),
        const SizedBox(height: 20),
        Text(
          "Session expired",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 8),
        Text(
          "Please try again or change payment method",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: _customColor.custom242424,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          height: 40,
          width: 129,
          decoration: BoxDecoration(
              color: _customColor.customF9E8CC,
              borderRadius: BorderRadius.circular(100)),
          child: TextButton(
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
            onPressed: () {},
            child: Text(
              "Request funds",
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
