import 'package:flutter/material.dart';
import 'package:tever/view/widgets/general/authentication/authentication_layout.dart';
import 'package:tever/view/widgets/reset_password_screen/reset_password_form.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  Future<void> _submit(String password, String cpassword) async {
    return; //"ref.read(authProvider.notifier).onBoard(signUpState: authState)";
  }

  @override
  Widget build(BuildContext context) {
    return AuthenticationLayout(
      title: "Reset password",
      subTitle: "Create a new password",
      body: Column(
        children: [
          ResetPasswordForm(
            setLoadingState: () {},
            submit: _submit,
          )
        ],
      ),
    );
  }
}
