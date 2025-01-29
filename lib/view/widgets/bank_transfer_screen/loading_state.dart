import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/lds_loading_spinner.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const LdsLoadingSpinner(),
        const SizedBox(height: 24),
        Text(
          "Taking you to a payment gateway",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: _customColor.custom242424,
          ),
        )
      ],
    );
  }
}
