import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/input_validation_controller.dart';
import 'package:tever/extensions/auth_status.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/auth.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/widgets/forgot_password_screem/bottom_section.dart';
import 'package:tever/view/widgets/forgot_password_screem/input_email.dart';
import 'package:tever/view/widgets/forgot_password_screem/input_phone_number.dart';
import 'package:tever/view/widgets/general/authentication/authentication_layout.dart';

import 'package:tever/view/widgets/forgot_password_screem/email.dart';
import 'package:tever/view/widgets/forgot_password_screem/phone.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/sign_up_screen/email_input.dart';

import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';
import 'package:tever/view/widgets/sign_up_screen/tab_switcher.dart';

class InputPhoneNumberEmailForForgotPassword extends ConsumerStatefulWidget {
  final VoidCallback proceedToNextSection;
  const InputPhoneNumberEmailForForgotPassword({
    super.key,
    required this.proceedToNextSection,
  });

  @override
  ConsumerState<InputPhoneNumberEmailForForgotPassword> createState() =>
      _InputPhoneNumberEmailForForgotPasswordState();
}

class _InputPhoneNumberEmailForForgotPasswordState
    extends ConsumerState<InputPhoneNumberEmailForForgotPassword> {
  final List<Widget> _sections = [];

  bool _isLoading = false;

  bool _emailError = true;

  bool _phoneNumberError = true;

  final CustomColors _customColor = const CustomColors();

  final GlobalKey<FormFieldState<String>> _phoneKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();

  void _emailOnSaveHandler(String email) {
    print("set email $email");
    ref.read(authProvider.notifier).updateField("email", email);
  }

  void _phoneNumberOnSaveHandler(String phoneNumber) {
    print("sett");
    ref.read(authProvider.notifier).updateField("phoneNumber", phoneNumber);
  }

  void _emailValidator(bool hasError) {
    _emailError = hasError;
  }

  void _phoneNumberValidator(bool hasError) {
    _phoneNumberError = hasError;
  }

  int _activeSection = 0;

  void _selectSection(int index) {
    setState(() {
      _activeSection = index;
    });
  }

  void _showErrorToast(String message) {
    if (mounted) {
      ToastService.showToast(
        context: context,
        message: message,
        status: ToastStatus.error.name,
      );
    }
  }

  final TextEditingController _phoneController = TextEditingController();

  Future<void> _handleContinue() async {
    bool isValid = false;

    print("submitted");

    if (_activeSection == 0) {
      _phoneKey.currentState?.validate() ?? false;

      isValid = !_phoneNumberError;
      if (isValid) {
        _phoneKey.currentState?.save();
      }
    } else if (_activeSection == 1) {
      _emailKey.currentState?.validate() ?? false;

      isValid = !_emailError;

      if (isValid) {
        _emailKey.currentState?.save();
      }
    }

    print(isValid);
    if (!isValid) {
      return;
    }

    String authState =
        _activeSection == 1 ? AuthStatus.email.value : AuthStatus.phone.value;
    print(authState);

    ref.read(authProvider.notifier).updateField("authType", authState);

    setState(() {
      _isLoading = true;
    });

    try {
      print("sssssys");
      await ref.read(authProvider.notifier).sendOnBoardOTP();

      widget.proceedToNextSection();
    } on CustomHttpException catch (error) {
      final errorMessage = error.toString();

      _showErrorToast(errorMessage);
    } catch (error) {
      String errorMessage = "Something went wrong!";

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }

      _showErrorToast(errorMessage);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _sections.addAll([
      InputPhoneNumber(
        phoneKey: _phoneKey,
        phoneNumberValidator: _phoneNumberValidator,
        phoneNumberOnSaveHandler: _phoneNumberOnSaveHandler,
      ),
      InputEmail(
        emailKey: _emailKey,
        emailOnSaveHandler: _emailOnSaveHandler,
        emailValidator: _emailValidator,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        TabSwitcher(activeSection: _activeSection, onTap: _selectSection),
        IndexedStack(
          index: _activeSection,
          children: _sections,
        ),
        const SizedBox(
          height: 56,
        ),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: TextButton(
            onPressed: _handleContinue,
            style: TextButton.styleFrom(
              backgroundColor:
                  _isLoading ? _customColor.customD1D1D1 : theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: _isLoading
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
      ],
    );
  }
}
