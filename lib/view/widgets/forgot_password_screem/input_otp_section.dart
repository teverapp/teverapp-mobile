import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/extensions/auth_status.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/screens/set_a_password_screen.dart';
import 'package:tever/view/widgets/forgot_password_screem/bottom_section.dart';
import 'package:tever/view/widgets/general/authentication/authentication_layout.dart';

import 'package:tever/view/widgets/forgot_password_screem/email.dart';
import 'package:tever/view/widgets/forgot_password_screem/phone.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/otp_screen/otp_inputs.dart';
import 'package:tever/view/widgets/otp_screen/resend_otp.dart';
import 'package:tever/view/widgets/sign_up_screen/email_input.dart';

import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';
import 'package:tever/view/widgets/sign_up_screen/tab_switcher.dart';

class InputOtpSection extends ConsumerStatefulWidget {
  final Function setIsLoading;
  const InputOtpSection({super.key, required this.setIsLoading});

  @override
  ConsumerState<InputOtpSection> createState() => _InputOtpSectionState();
}

class _InputOtpSectionState extends ConsumerState<InputOtpSection> {
  final List<Widget> _sections = [
    Phone(),
    Email(),
  ];

  bool _loadedIntialData = false;

  late int _activeSection;

  void _selectSection(int index) {
    // setState(() {
    //   _activeSection = index;
    // });
    return;
  }

  Future<void> _resendOtp() async {
    return ref.read(authProvider.notifier).sendOnBoardOTP();
  }

  void _navigate(Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<void> _verifyOtp(String otp) async {
    // print("object");
    // await ref.read(authProvider.notifier).verifyOnBoardOtp(otp: otp);

    // if (mounted) {
    //   _navigate(const SetAPasswordScreen());
    // }

    widget.setIsLoading(true);

    try {
      await ref.read(authProvider.notifier).verifyOnBoardOtp(
            otp: otp,
            action: "forgot-password",
          );

      if (mounted) {
        _navigate(const SetAPasswordScreen(screenUsedForResetPassword: true));
      }
    } on CustomHttpException catch (error) {
      if (mounted) {
        ToastService.showToast(
            context: context,
            message: error.toString(),
            status: ToastStatus.error.name);
      }
    } catch (error) {
      String errorMessage = "Something went wrong!";

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
      widget.setIsLoading(false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedIntialData) {
      final authInfo = ref.watch(authProvider);

      _activeSection = authInfo.authType == AuthStatus.email.value ? 1 : 0;

      _loadedIntialData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabSwitcher(activeSection: _activeSection, onTap: _selectSection),
        IndexedStack(
          index: _activeSection,
          children: _sections,
        ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Please enter the OTP to continue.",
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 24),
        OtpInputs(
          submit: _verifyOtp,
        ),
        const SizedBox(height: 24),
        Align(
            alignment: Alignment.topLeft,
            child: ResenOtp(resendOtp: _resendOtp)),
        // const SizedBox(height: 56),
        // SizedBox(
        //   height: 56,
        //   width: double.infinity,
        //   child: TextButton(
        //     onPressed: () {},
        //     style: TextButton.styleFrom(
        //       backgroundColor: theme.primaryColor,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(100),
        //       ),
        //     ),
        //     child: const Text(
        //       "Continue",
        //       style: TextStyle(
        //         fontSize: 16,
        //         fontWeight: FontWeight.w600,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
