import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/input_validation_controller.dart';
import 'package:tever/model/auth.dart';
import 'package:tever/view/widgets/forgot_password_screem/common_widget.dart';

class Phone extends ConsumerWidget {
  Phone({super.key});

  final InputValidationController _valdate = InputValidationController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Auth authData = ref.watch(authProvider);

    return CommonWidget(
      title:
          "A one time password (OTP) has been sent to your phone number ending with  ",
      subTitle: _valdate.getLastFourCharacters(authData.phoneNumber.toString()),
    );
  }
}
