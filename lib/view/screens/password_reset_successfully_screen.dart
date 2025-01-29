import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/widgets/general/authentication/authentication_layout.dart';
import 'package:tever/view/widgets/reset_password_screen/reset_password_form.dart';

class PasswordResetSuccessfullyScreen extends StatelessWidget {
  const PasswordResetSuccessfullyScreen({super.key});

  final CustomColors _customColor = const CustomColors();

  void _navigate(Widget screen, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final theme = Theme.of(context);

    final height = mediaQuery.height * 0.3;
    return AuthenticationLayout(
      showSubtitle: false,
      showTitle: false,
      isScrollable: false,
      body: Expanded(
          child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height),
                  Text(
                    "Password reset successful",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _customColor.custom242424,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Continue to log in with your new password.",
                    style: TextStyle(
                        fontSize: 14,
                        color: _customColor.custom2E3438,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 56),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => _navigate(const SignInScreen(), context),
                      style: TextButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
