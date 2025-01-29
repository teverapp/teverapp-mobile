import 'package:flutter/material.dart';
import 'package:tever/view/widgets/otp_screen/otp_inputs.dart';
import 'package:tever/view/widgets/otp_screen/resend_otp.dart';

class BottomSection extends StatelessWidget {
  final int activeSection;
  final Future<void> Function() resendOtp;
  const BottomSection(
      {super.key, required this.activeSection, required this.resendOtp});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [],
    );
  }
}
