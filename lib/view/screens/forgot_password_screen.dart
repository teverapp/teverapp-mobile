import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/extensions/auth_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/waiting_screen.dart';
import 'package:tever/view/widgets/forgot_password_screem/bottom_section.dart';
import 'package:tever/view/widgets/forgot_password_screem/input_otp_section.dart';
import 'package:tever/view/widgets/forgot_password_screem/input_phone_number_email_for_forgot_password.dart';
import 'package:tever/view/widgets/general/authentication/authentication_layout.dart';

import 'package:tever/view/widgets/forgot_password_screem/email.dart';
import 'package:tever/view/widgets/forgot_password_screem/phone.dart';
import 'package:tever/view/widgets/sign_up_screen/email_input.dart';

import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';
import 'package:tever/view/widgets/sign_up_screen/tab_switcher.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  bool _isLoading = false;

  void _setIsLoading(bool value) {
    print("obhecr $value");
    setState(() {
      _isLoading = value;
    });
  }

  int _activeSection = 0;

  void _proceedToNextSection() {
    setState(() {
      _activeSection = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AuthenticationLayout(
          title: "Forgot password",
          showSubtitle: false,
          body: Column(
            children: [
              if (_activeSection == 0)
                InputPhoneNumberEmailForForgotPassword(
                    proceedToNextSection: _proceedToNextSection),
              if (_activeSection == 1)
                InputOtpSection(setIsLoading: _setIsLoading),
            ],
          ),
        ),
        if (_isLoading)
          const Positioned.fill(
            child: WaitingScreen(
              title: "Verifying, Please wait...",
            ),
          )
      ],
    );
  }
}
