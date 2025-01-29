import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

class ResenOtp extends StatefulWidget {
  final Future<void> Function() resendOtp;
  const ResenOtp({super.key, required this.resendOtp});

  @override
  State<ResenOtp> createState() => _ResenOtpState();
}

class _ResenOtpState extends State<ResenOtp> {
  final CustomColors _customColor = const CustomColors();

  int _resendOTPCountDown = 60;

  bool _isLoading = false;

  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendOTPCountDown > 0) {
          _resendOTPCountDown--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _resendOTPCountDown = 60;
    });
    _startTimer();
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.resendOtp();

      if (mounted) {
        _resetTimer();

        ToastService.showToast(
            context: context,
            message: "OTP resent successfully!",
            status: ToastStatus.success.name);
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
          children: [
            const TextSpan(
              text: "Didn't receive code? ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_isLoading)
              WidgetSpan(
                  child: Container(
                height: 13,
                width: 13,
                margin: const EdgeInsets.only(left: 5, bottom: 1),
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                ),
              )),
            if (!_isLoading)
              TextSpan(
                text: _resendOTPCountDown == 0
                    ? "Resend OTP"
                    : "Resend OTP in (${_resendOTPCountDown.toString().padLeft(2, '0')})",
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => _resendOTPCountDown == 0 ? _resendOtp() : null,
              ),
          ],
          style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 14,
              height: 1.3,
              fontFamily: 'Inter')),
    );
  }
}
