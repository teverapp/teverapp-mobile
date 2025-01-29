import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class RequestAccepted extends StatelessWidget {
  const RequestAccepted({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(
          height: 35,
          width: double.infinity,
        ),
        Image.asset(
          "assets/icon/approved.png",
          height: 64,
          width: 64,
        ),
        const SizedBox(height: 20),
        Text(
          "{Username} accepted your request",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
              children: [
                const TextSpan(
                  text: "Awaiting fund transfer of  ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "₦7,000",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(
                  text: "from {username}",
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
        const SizedBox(height: 7),
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
