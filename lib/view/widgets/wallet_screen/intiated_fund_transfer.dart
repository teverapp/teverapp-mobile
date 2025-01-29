import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class IntiatedFundTransfer extends StatelessWidget {
  const IntiatedFundTransfer({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(
          height: 30,
          width: double.infinity,
        ),
        Image.asset(
          "assets/icon/approved.png",
          height: 64,
          width: 64,
        ),
        const SizedBox(height: 20),
        Text(
          "{Username} has initiated fund transfer",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 10),
        Text(
          "You have received a fund of ₦7,000 from {username}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: _customColor.custom242424,
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
