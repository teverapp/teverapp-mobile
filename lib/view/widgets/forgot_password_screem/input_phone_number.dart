import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/forgot_password_screem/common_widget.dart';
import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';

class InputPhoneNumber extends ConsumerWidget {
  final GlobalKey<FormFieldState<String>> phoneKey;
  final Function phoneNumberOnSaveHandler;
  final Function phoneNumberValidator;
  const InputPhoneNumber({
    super.key,
    required this.phoneKey,
    required this.phoneNumberOnSaveHandler,
    required this.phoneNumberValidator,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authInfo = ref.watch(authProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
            "Enter the phone number you registered with to receive an OTP to continue.",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: _customColor.custom4F4F4F,
                fontSize: 14,
                height: 1.3,
                fontFamily: 'Inter')),
        const SizedBox(height: 20),
        Text(
          "Phone number",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        PhoneInput(
            hideTopGap: true,
            phoneKey: phoneKey,
            validator: phoneNumberValidator,
            onSave: phoneNumberOnSaveHandler,
            selectedCountryAcronym: authInfo.countryCode.toString(),
            selectedCountryFlag: authInfo.countryFlag.toString(),
            selectedCountryPhoneCode: authInfo.countryPhoneCode.toString(),
            key: const ValueKey("phoneInput")),
      ],
    );
  }
}
