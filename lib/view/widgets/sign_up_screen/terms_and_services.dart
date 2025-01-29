import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class TermsAndServices extends StatelessWidget {
  final String title;
  const TermsAndServices({super.key, required this.title});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RichText(
      text: TextSpan(
          children: [
            TextSpan(text: "$title "),
            TextSpan(
              text: "Terms of Service ",
              style: TextStyle(
                color: theme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
              // recognizer: TapGestureRecognizer()
              //   ..onTap =,
              //       () => _resendOtpLink(email.toString())
            ),
            const TextSpan(text: " & "),
            TextSpan(
              text: "Privacy Policy.",
              style: TextStyle(
                color: theme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              // recognizer: TapGestureRecognizer()
              //   ..onTap =
              //       () => _resendOtpLink(email.toString())
              //
            ),
          ],
          style: TextStyle(
              color: _customColor.cutom888888,
              fontSize: 12,
              height: 1.3,
              fontFamily: 'Inter')),
    );
  }
}
