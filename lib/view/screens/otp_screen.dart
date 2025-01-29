import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/screens/waiting_screen.dart';
import 'package:tever/view/widgets/general/authentication/authentication_layout.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/otp_screen/otp_inputs.dart';
import 'package:tever/view/widgets/otp_screen/resend_otp.dart';

class OtpScreen extends StatefulWidget {
  final String title;
  final String subTitle;
  final Future<void> Function() resendOtp;
  final Future<void> Function(String) verifyOtp;

  const OtpScreen(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.resendOtp,
      required this.verifyOtp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _isLoading = false;

  Future<void> _submit(String otp) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.verifyOtp(otp);
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
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AuthenticationLayout(
          title: widget.title,
          subTitle: widget.subTitle,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OtpInputs(submit: _submit),
              const SizedBox(height: 24),
              ResenOtp(
                resendOtp: widget.resendOtp,
              ),
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
