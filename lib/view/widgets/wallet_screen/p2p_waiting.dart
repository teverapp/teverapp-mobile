import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/rotate_image.dart';

class P2pWaiting extends StatelessWidget {
  const P2pWaiting({super.key});

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
        const RotateImage(
            imageHeight: 40,
            imageUrl: "assets/icon/hour_glass.png",
            imageWidth: 40),
        const SizedBox(height: 20),
        Text(
          "Your request has been sent to {username}",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 10),
        Text(
          "Please hold while we await response from {username}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: _customColor.custom242424,
          ),
        ),
        RichText(
          text: TextSpan(
              children: [
                const TextSpan(
                  text: "Session will expire in  ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "29:59 ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor,
                  ),
                ),
                const TextSpan(
                  text: " seconds",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom242424,
                  height: 1.3,
                  fontFamily: 'Inter')),
        ),
        const SizedBox(
          height: 40,
          width: double.infinity,
        ),
      ],
    );
  }
}
