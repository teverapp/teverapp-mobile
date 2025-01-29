import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/lds_loading_spinner.dart';

class TransactionFailed extends StatelessWidget {
  const TransactionFailed({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icon/alert_triangle.png",
          height: 80,
          width: 80,
        ),
        const SizedBox(height: 10),
        Text(
          "Transaction failed",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424,
              fontFamily: "Anybody"),
        ),
        const SizedBox(height: 8),
        Container(
            constraints: const BoxConstraints(maxWidth: 340),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Your transaction could not be processed at this time due to an error",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom6D6D6D),
            )),
        const SizedBox(height: 16),
        SizedBox(
          height: 48,
          width: 144,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text(
              "Try again",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
