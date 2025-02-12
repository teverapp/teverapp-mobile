import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

class PromoteAsTeverTopPick extends ConsumerStatefulWidget {
  const PromoteAsTeverTopPick({super.key});

  @override
  ConsumerState<PromoteAsTeverTopPick> createState() =>
      _PromoteAsTeverTopPickState();
}

class _PromoteAsTeverTopPickState extends ConsumerState<PromoteAsTeverTopPick> {
  final CustomColors _customColor = const CustomColors();

  bool _isLoading = false;

  void _showToast({required String message, required String status}) {
    if (mounted) {
      ToastService.showToast(
        context: context,
        message: message,
        status: status,
      );
    }
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
    setState(() {
      _isLoading = true;
    });

    try {
      await ref
          .read(newDealDataProvider.notifier)
          .promoteCreatedDealAsTopPick();

      _showToast(
          message: "Deal added to top pick successfully!",
          status: ToastStatus.success.name);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
        onTap: _isLoading ? null : _submit,
        child: Row(
          children: [
            if (_isLoading)
              SizedBox(
                height: 17,
                width: 17,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                  strokeWidth: 3,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                ),
              ),
            if (!_isLoading)
              Image.asset(
                "assets/icon/radio_circular_inactive.png",
                height: 20,
                width: 20,
              ),
            const SizedBox(width: 8),
            Text(
              "Promote deal as Tever's top pick",
              style: TextStyle(
                  fontSize: 14,
                  color: _customColor.custom242424,
                  fontWeight: FontWeight.w500),
            )
          ],
        ));
  }
}
