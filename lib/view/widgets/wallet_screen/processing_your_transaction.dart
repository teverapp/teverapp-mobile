import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/lds_loading_spinner.dart';

class ProcessingYourTransaction extends StatelessWidget {
  const ProcessingYourTransaction({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 236,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LdsLoadingSpinner(),
          const SizedBox(height: 25),
          Text(
            "Processing your transaction",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: _customColor.custom242424,
            ),
          )
        ],
      ),
    );
  }
}
