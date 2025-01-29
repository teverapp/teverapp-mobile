import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tever/extensions/auth_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/screens/sign_up_screen.dart';
import 'package:tever/view/widgets/sign_up_screen/terms_and_services.dart';

class BottomSection extends StatefulWidget {
  final bool normalAuthIsLoading;
  final int activeSection;
  final String authState;
  final VoidCallback continueBtn;
  final Function? validator;
  final Function? onSave;
  final GlobalKey<FormFieldState<String>>? passwordKey;
  final VoidCallback? navigateToForgotpasswordScreen;
  const BottomSection(
      {super.key,
      this.normalAuthIsLoading = false,
      required this.activeSection,
      required this.authState,
      required this.continueBtn,
      this.onSave,
      this.passwordKey,
      this.validator,
      this.navigateToForgotpasswordScreen});

  @override
  State<BottomSection> createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  final CustomColors _customColor = const CustomColors();

  bool _passwordObsured = true;

  String? _errorMessage;

  String? _validateEmail(String? value) {
    print("numver val");
    if (value == null || value.isEmpty) {
      _updateErrorMessage('Password is required');

      return null;
    }

    _updateErrorMessage(null);
    return null;
  }

  void _updateErrorMessage(String? errorMessage) {
    setState(() => _errorMessage = errorMessage);
    widget.validator!(errorMessage != null);
  }

  void _navigateToNextScreen(
      {required BuildContext context, required Widget screen}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    print("numver val --- $_errorMessage");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        if (AuthStatus.signup.value == widget.authState)
          TermsAndServices(
              title: widget.activeSection == 0
                  ? "We will send a text with a verification code. Message and data rates may apply. By continuing, you agree to our"
                  : "We will send an email with a verification code."),
        if (AuthStatus.signin.value == widget.authState)
          const SizedBox(height: 20),
        if (AuthStatus.signin.value == widget.authState)
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Password",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
          ),
        const SizedBox(height: 8),
        if (AuthStatus.signin.value == widget.authState)
          Container(
            height: 46,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: _customColor.customRgba1,
                  blurRadius: 0,
                  spreadRadius: 4,
                  offset: const Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextFormField(
              key: widget.passwordKey,
              obscureText: _passwordObsured,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter password',
                counterText: "",
                filled: true,
                contentPadding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                suffixIconConstraints:
                    const BoxConstraints(maxHeight: 150, maxWidth: 150),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _passwordObsured = !_passwordObsured;
                    }),
                    child: Image.asset(
                      _passwordObsured
                          ? "assets/icon/eye_slash.png"
                          : "assets/icon/eye.png",
                      height: 16,
                      width: 16,
                    ),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _errorMessage == null
                        ? _customColor.custom50A4D4
                        : theme.colorScheme.error,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _errorMessage == null
                        ? _customColor.custom50A4D4
                        : theme.colorScheme.error,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      width: 1,
                      color: _errorMessage != null
                          ? theme.colorScheme.error
                          : Colors.transparent),
                ),
                hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom888888,
                ),
              ),
              onChanged: _validateEmail,
              validator: _validateEmail,
              onSaved: (value) {
                if (widget.onSave != null) {
                  widget.onSave!(value);
                }
              },
            ),
          ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              _errorMessage!,
              style: TextStyle(fontSize: 12, color: theme.colorScheme.error),
            ),
          ),
        ],
        if (AuthStatus.signin.value == widget.authState)
          const SizedBox(height: 15),
        if (AuthStatus.signin.value == widget.authState)
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => widget.navigateToForgotpasswordScreen!(),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1, color: theme.colorScheme.error))),
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        SizedBox(height: AuthStatus.signin.value == widget.authState ? 24 : 14),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: TextButton(
            onPressed: widget.normalAuthIsLoading ? null : widget.continueBtn,
            style: TextButton.styleFrom(
              backgroundColor: widget.normalAuthIsLoading
                  ? _customColor.customD1D1D1
                  : theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: widget.normalAuthIsLoading
                ? SizedBox(
                    height: 23,
                    width: 23,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                      strokeWidth: 3,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(theme.primaryColor),
                    ),
                  )
                : const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Divider(thickness: 1, color: _customColor.customEFEFEF),
            ),
            const SizedBox(width: 16),
            Text(
              "OR",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _customColor.customB0B0B0,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Divider(thickness: 1, color: _customColor.customEFEFEF),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: _customColor.customDCDCDC),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icon/google.png", height: 20, width: 20),
                const SizedBox(width: 10),
                Text(
                  "Continue with Google",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: _customColor.custom1F2937,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: [
                TextSpan(
                  text: AuthStatus.signin.value == widget.authState
                      ? "Don't have an account? "
                      : "Already have an account? ",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                    text: AuthStatus.signin.value == widget.authState
                        ? "Sign up"
                        : "Log in",
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _navigateToNextScreen(
                          context: context,
                          screen: AuthStatus.signin.value == widget.authState
                              ? const SignUpScreen()
                              : const SignInScreen())),
              ],
              style: TextStyle(
                  color: _customColor.custom242424,
                  fontSize: 14,
                  height: 1.3,
                  fontFamily: 'Inter')),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
