import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/screens/tabs_screen.dart';
import 'package:tever/view/screens/waiting_screen.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/otp_screen/otp_inputs.dart';
import 'package:tever/view/widgets/otp_screen/resend_otp.dart';

class CompleteProfileVerificationBottomSheet extends ConsumerStatefulWidget {
  final String title;
  final String subTitle;
  const CompleteProfileVerificationBottomSheet({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  ConsumerState<CompleteProfileVerificationBottomSheet> createState() =>
      _CompleteProfileVerificationBottomSheetState();
}

class _CompleteProfileVerificationBottomSheetState
    extends ConsumerState<CompleteProfileVerificationBottomSheet> {
  final CustomColors _customColor = const CustomColors();

  bool _isLoading = false;

  Future<void> _resendOtp() async {
    return ref.read(authProvider.notifier).sendOnBoardOTP();
  }

  void _showToast({required String message, required String status}) {
    if (mounted) {
      ToastService.showToast(
        context: context,
        message: message,
        status: status,
      );
    }
  }

  Future<void> _submit(String otp) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(authProvider.notifier).verifyOnBoardOtp(
            otp: otp,
            action: "onboard",
          );

      ref.read(authProvider.notifier).resetAuthData();

      if (mounted) {
        if (ModalRoute.of(context)?.isCurrent == true) {
          Navigator.of(context).pop();
        }

        ref
            .read(userDataProvider.notifier)
            .updateField("hasSetUpProfile", true);

        _showToast(
            message: "Your profile has been updated successfully!",
            status: ToastStatus.success.name);

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const TabsScreen()),
          );
        }
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
      _showToast(message: errorMessage, status: ToastStatus.error.name);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final height = mediaQuery.height * 0.7;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 5,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: _customColor.custom6D6D6D,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Anybody",
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.subTitle,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _customColor.custom5D5D5D),
                ),
                const SizedBox(height: 24),
                OtpInputs(submit: _submit),
                const SizedBox(height: 28),
                ResenOtp(
                  resendOtp: _resendOtp,
                ),
              ],
            ),
            if (_isLoading)
              const Positioned.fill(
                child: WaitingScreen(
                  hideScaffold: true,
                  title: "Verifying, Please wait...",
                ),
              )
          ],
        ),
      ),
    );
  }
}
