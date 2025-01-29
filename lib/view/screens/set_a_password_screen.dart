import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/screens/password_reset_successfully_screen.dart';
import 'package:tever/view/screens/tabs_screen.dart';
import 'package:tever/view/screens/waiting_screen.dart';
import 'package:tever/view/widgets/general/authentication/authentication_layout.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/reset_password_screen/reset_password_form.dart';

class SetAPasswordScreen extends ConsumerStatefulWidget {
  final bool screenUsedForResetPassword;
  const SetAPasswordScreen(
      {super.key, this.screenUsedForResetPassword = false});

  @override
  ConsumerState<SetAPasswordScreen> createState() => _SetAPasswordScreenState();
}

class _SetAPasswordScreenState extends ConsumerState<SetAPasswordScreen> {
  bool _isLoading = false;

  void setLoadingState(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  Future<void> submit(String password, String cPassword) async {
    await ref
        .read(authProvider.notifier)
        .forgotResetPassword(password: password, confirmPassword: cPassword);

    ref.read(authProvider.notifier).updateField("isGuest", false);

    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => widget.screenUsedForResetPassword
                ? const PasswordResetSuccessfullyScreen()
                : const TabsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AuthenticationLayout(
          title: "Set a password",
          subTitle: "Create a password",
          body: Column(
            children: [
              ResetPasswordForm(
                setLoadingState: setLoadingState,
                submit: submit,
              ),
            ],
          ),
        ),
        if (_isLoading)
          Positioned.fill(
              child: WaitingScreen(
                  title: widget.screenUsedForResetPassword
                      ? "Updating your password. Please wait..."
                      : "Sit tight while we prepare your Tever home..."))
      ],
    );
  }
}
