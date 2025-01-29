import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/forgot_password_screem/common_widget.dart';
import 'package:tever/view/widgets/sign_up_screen/email_input.dart';
import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';

class InputEmail extends StatelessWidget {
  final GlobalKey<FormFieldState<String>> emailKey;
  final Function emailOnSaveHandler;
  final Function emailValidator;
  const InputEmail({
    super.key,
    required this.emailKey,
    required this.emailOnSaveHandler,
    required this.emailValidator,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
            "Enter the email address you registered with to receive an OTP to continue.",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: _customColor.custom4F4F4F,
                fontSize: 14,
                height: 1.3,
                fontFamily: 'Inter')),
        const SizedBox(height: 20),
        Text(
          "Email address",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        EmailInput(
          emailKey: emailKey,
          onSave: emailOnSaveHandler,
          hideTopGap: true,
          validator: emailValidator,
          key: const ValueKey("emailInput"),
        ),
      ],
    );
  }
}
