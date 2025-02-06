import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_info_controller.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/input_validation_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/extensions/auth_status.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/screens/tabs_screen.dart';
import 'package:tever/view/widgets/complete_your_profile_screen/complete_profile_verification_bottom_sheet.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/sign_up_screen/email_input.dart';
import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';
import 'package:tever/view/widgets/tabs/home_tab/business_profile_created_successfull_bottom_sheet.dart';

class CompleteProfileForm extends ConsumerStatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  ConsumerState<CompleteProfileForm> createState() =>
      _CompleteProfileFormState();
}

class _CompleteProfileFormState extends ConsumerState<CompleteProfileForm> {
  final CustomColors _customColor = const CustomColors();

  bool _isLoading = false;

  bool _hasVerifiedPhoneNumberEmail = false;

  final InputValidationController _validateInput = InputValidationController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _hasFetechedInitialData = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _showToast({required String message, required String status}) {
    if (mounted) {
      ToastService.showToast(
        context: context,
        message: message,
        status: status,
      );
    }
  }

  void _emailPhoneNumberVerificationBottomSheet({
    required String title,
    required String subTitle,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return CompleteProfileVerificationBottomSheet(
          title: title,
          subTitle: subTitle,
        );
      },
    );
  }

  void _navigateToSignInScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final userData = ref.watch(userDataProvider);

    String authState;
    String title;
    String subTitle;

    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(userDataProvider.notifier).completeProfile(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phoneNumber: _phoneNumberController.text);

      if (!userData.isEmailVerified!) {
        authState = AuthStatus.email.value;
        ref.read(authProvider.notifier).updateField("authType", authState);
        ref
            .read(authProvider.notifier)
            .updateField("email", _emailController.text);
        title = "Verify email address";

        subTitle =
            "A verification code has been sent to your email address ${_validateInput.maskEmail(_emailController.text)}";

        // ref
        //     .read(authProvider.notifier)
        //     .updateField("email", _emailController.text);

        await ref.read(authProvider.notifier).sendOnBoardOTP();

        _hasVerifiedPhoneNumberEmail = true;

        if (mounted) {
          _emailPhoneNumberVerificationBottomSheet(
            title: title,
            subTitle: subTitle,
          );
        }
        //   return;
      } else if (!userData.isPhoneNumberVerified!) {
        authState = AuthStatus.phone.value;

        ref.read(authProvider.notifier).updateField("authType", authState);
        ref
            .read(authProvider.notifier)
            .updateField("phoneNumber", _phoneNumberController.text);
        title = "Authenticate...";

        subTitle =
            "A one-time passcode has been sent to your phone number ending with ${_validateInput.getLastFourCharacters(_phoneNumberController.text)}";

        // ref
        //     .read(authProvider.notifier)
        //     .updateField("phoneNumber", _phoneNumberController.text);

        await ref.read(authProvider.notifier).sendOnBoardOTP();

        _hasVerifiedPhoneNumberEmail = true;

        if (mounted) {
          _emailPhoneNumberVerificationBottomSheet(
              title: title, subTitle: subTitle);
        }
        // return;
      }
    } on CustomHttpException catch (error) {
      _showToast(message: error.toString(), status: ToastStatus.error.name);
    } catch (error) {
      String errorMessage = error.toString();

      if (errorMessage == "401") {
        _navigateToSignInScreen();

        return;
      }

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }
      _showToast(message: errorMessage, status: ToastStatus.error.name);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();

    _firstNameController.addListener(_updateFormValidity);
    _lastNameController.addListener(_updateFormValidity);
    _emailController.addListener(_updateFormValidity);
    _phoneNumberController.addListener(_updateFormValidity);
  }

  void _updateFormValidity() {
    if (!mounted) return;
    setState(() {
      _isFormValid = _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _validateInput.validateEmail(_emailController.text) &&
          _validateInput.validatePhoneNumber(_phoneNumberController.text);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasFetechedInitialData) {
      final userData = ref.watch(userDataProvider);

      print("usser infor ${userData.email} ${userData.phoneNumber}");

      _emailController.text = userData.email ?? "";

      _phoneNumberController.text = userData.phoneNumber ?? "";

      //_addressNameController.text = userData.currentAddress ?? "";

      _hasFetechedInitialData = true;
    }
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_updateFormValidity);
    _lastNameController.removeListener(_updateFormValidity);
    _emailController.removeListener(_updateFormValidity);
    _phoneNumberController.removeListener(_updateFormValidity);

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final selectedCountry = ref.read(appInfoProvider);

    final userData = ref.watch(userDataProvider);

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              "First name",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 9),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _firstNameController,
              style: TextStyle(
                color: _customColor.custom242424,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: "Enter your first name",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                border: OutlineInputBorder(
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please input first name!';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Text(
              "Last name",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 9),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _lastNameController,
              style: TextStyle(
                color: _customColor.custom242424,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: "Enter your last name",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                border: OutlineInputBorder(
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please input last name!';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            Text(
              "Phone number",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 9),
            PhoneInput(
              readOnly: userData.phoneNumber != null,
              controller: _phoneNumberController,
              selectedCountryFlag: selectedCountry.flag,
              selectedCountryAcronym: selectedCountry.countryCode,
              selectedCountryPhoneCode: selectedCountry.phoneCode,
              bgColor: Colors.white,
              hideTopGap: true,
            ),
            const SizedBox(height: 14),
            Text(
              "Email address",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 9),
            EmailInput(
              readOnly: userData.email != null,
              controller: _emailController,
              bgColor: Colors.white,
              hideTopGap: true,
              leadingIcon: "assets/icon/mail_dark.png",
              leadingIconHeight: 16,
              leadingIconWidth: 16,
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: TextButton(
                onPressed: !_isFormValid || _isLoading ? null : _submit,
                style: TextButton.styleFrom(
                  backgroundColor: !_isFormValid || _isLoading
                      ? _customColor.customD1D1D1
                      : theme.primaryColor,
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
                        "Save details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ));
  }
}
