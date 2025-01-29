import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tever/controller/input_validation_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

class ResetPasswordForm extends StatefulWidget {
  final Function setLoadingState;
  final Future<void> Function(String, String) submit;
  const ResetPasswordForm(
      {super.key, required this.submit, required this.setLoadingState});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CustomColors _customColor = const CustomColors();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordObsured = true;

  bool _cPasswordObscured = true;

  bool _hasMinmumLength = false;

  bool _hasLowerCase = false;

  bool _hasUpperCase = false;

  bool _hasNumbers = false;

  bool _hasSpeciaChar = false;

  bool _passwordsMatch = false;

  String? _errorMessage;

  String _level = "Empty";

  void _updateValidityCount(bool oldValue, bool newValue) {
    if (oldValue != newValue) {
      _validityCount += newValue ? 1 : -1;
    }
  }

  final InputValidationController _validate = InputValidationController();

  int _validityCount = 0;

  Widget buildPasswordCondition({required String title, required isValid}) {
    return Row(
      children: [
        Image.asset(
            "assets/icon/${isValid ? 'done.png' : 'close_circle_darker.png'}",
            height: 16,
            width: 16),
        const SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: _customColor.custom6D6D6D),
        )
      ],
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      _updateErrorMessage('Confirm password is required!');

      return null;
    }

    if (_passwordController.text != value) {
      _updateErrorMessage("Passwords does not match");

      return null;
    }

    _updateErrorMessage(null);
    return null;
  }

  void _updateErrorMessage(String? errorMessage) {
    setState(() {
      _passwordsMatch = errorMessage == null;
      _errorMessage = errorMessage;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.setLoadingState(true);
    print("called now");

    try {
      await widget.submit(
          _passwordController.text, _confirmPasswordController.text);
    } on CustomHttpException catch (error) {
      if (mounted) {
        ToastService.showToast(
            context: context,
            message: error.toString(),
            status: ToastStatus.error.name);
      }
    } catch (error) {
      String errorMessage = error.toString();

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }
      if (mounted) {
        ToastService.showToast(
            context: context,
            message: errorMessage,
            status: ToastStatus.error.name);
      }
    } finally {
      widget.setLoadingState(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    bool allPasswordConditionMet = _hasMinmumLength &&
        _hasLowerCase &&
        _hasUpperCase &&
        _hasNumbers &&
        _hasSpeciaChar &&
        _passwordsMatch;

    _level = _validityCount == 0
        ? "Empty"
        : _validityCount == 1
            ? "Very Weak"
            : _validityCount == 2
                ? "Weak"
                : _validityCount == 3
                    ? "Moderate"
                    : _validityCount == 4
                        ? "Strong"
                        : "Very Strong";

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          SizedBox(
            height: 55,
            child: TextFormField(
              controller: _passwordController,
              obscureText: _passwordObsured,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter password',
                counterText: "",
                filled: true,
                contentPadding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 40),
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
                      height: 19,
                      width: 19,
                    ),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _customColor.customEFEFEF,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _customColor.customEFEFEF,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1),
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom888888,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  final hasMinimumLength = _validate.hasMinimumLength(value, 6);
                  final hasLowerCase = _validate.containsLowercase(value);
                  final hasUpperCase = _validate.containsUppercase(value);
                  final hasNumbers = _validate.containsNumber(value);
                  final hasSpecialChar =
                      _validate.containsSpecialCharacter(value);

                  // Update _validityCount based on condition changes
                  _updateValidityCount(_hasMinmumLength, hasMinimumLength);
                  _updateValidityCount(_hasLowerCase, hasLowerCase);
                  _updateValidityCount(_hasUpperCase, hasUpperCase);
                  _updateValidityCount(_hasNumbers, hasNumbers);
                  _updateValidityCount(_hasSpeciaChar, hasSpecialChar);

                  // Update condition states
                  _hasMinmumLength = hasMinimumLength;
                  _hasLowerCase = hasLowerCase;
                  _hasUpperCase = hasUpperCase;
                  _hasNumbers = hasNumbers;
                  _hasSpeciaChar = hasSpecialChar;
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: index + 1 == 5 ? 0 : 4),
                      decoration: BoxDecoration(
                          color: index + 1 > _validityCount
                              ? _customColor.custom50A4D4.withOpacity(0.5)
                              : _customColor.custom50A4D4,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Level: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: _level,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  style: TextStyle(
                      color: _customColor.custom242424,
                      fontSize: 14,
                      height: 1.3,
                      fontFamily: 'Inter')),
            ),
          ),
          const SizedBox(height: 16),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Your password must contain:",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom242424),
              )),
          const SizedBox(height: 8),
          buildPasswordCondition(
              title: "Minimum number of characters is 6.",
              isValid: _hasMinmumLength),
          const SizedBox(height: 7),
          buildPasswordCondition(
              title: "Should contain lowercase.", isValid: _hasLowerCase),
          const SizedBox(height: 7),
          buildPasswordCondition(
              title: "Should contain uppercase.", isValid: _hasUpperCase),
          const SizedBox(height: 7),
          buildPasswordCondition(
              title: "Should contain numbers.", isValid: _hasNumbers),
          const SizedBox(height: 7),
          buildPasswordCondition(
              title: "Should contain special characters.",
              isValid: _hasSpeciaChar),
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Confirm Password",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 55,
            child: TextFormField(
              obscureText: _cPasswordObscured,
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Confirm password',
                counterText: "",
                filled: true,
                contentPadding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 40),
                suffixIconConstraints:
                    const BoxConstraints(maxHeight: 150, maxWidth: 150),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _cPasswordObscured = !_cPasswordObscured;
                    }),
                    child: Image.asset(
                      _cPasswordObscured
                          ? "assets/icon/eye_slash.png"
                          : "assets/icon/eye.png",
                      height: 19,
                      width: 19,
                    ),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _customColor.customEFEFEF,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _customColor.customEFEFEF,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1),
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom888888,
                ),
              ),
              onChanged: _validatePassword,
              validator: _validatePassword,
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
          const SizedBox(height: 40),
          SizedBox(
            height: 56,
            width: double.infinity,
            child: TextButton(
              onPressed: allPasswordConditionMet ? _submit : null,
              style: TextButton.styleFrom(
                backgroundColor: !allPasswordConditionMet
                    ? _customColor.customD1D1D1
                    : theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 540),
        ],
      ),
    );
  }
}
