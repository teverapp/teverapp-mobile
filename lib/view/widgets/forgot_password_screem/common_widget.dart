import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class CommonWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const CommonWidget({super.key, required this.title, required this.subTitle});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                  // recognizer: TapGestureRecognizer()
                  //   ..onTap =,
                  //       () => _resendOtpLink(email.toString())
                ),
                TextSpan(
                  text: subTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  // recognizer: TapGestureRecognizer()
                  //   ..onTap =
                  //       () => _resendOtpLink(email.toString())
                  //
                ),
              ],
              style: TextStyle(
                  color: _customColor.custom4F4F4F,
                  fontSize: 14,
                  height: 1.3,
                  fontFamily: 'Inter')),
        ),
      ],
    );
  }
}
