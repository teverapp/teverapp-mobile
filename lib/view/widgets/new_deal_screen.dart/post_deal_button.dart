import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

class PostDealButton extends ConsumerStatefulWidget {
  final Function next;
  const PostDealButton({super.key, required this.next});

  @override
  ConsumerState<PostDealButton> createState() => _PostDealButtonState();
}

class _PostDealButtonState extends ConsumerState<PostDealButton> {
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
          .uploadDeal(saveToDraft: false);

      _showToast(
          message: "Deal created successfully",
          status: ToastStatus.success.name);

      widget.next(3);
      // widget.next(3);
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

    final newDealsData = ref.watch(newDealDataProvider);

    final userData = ref.watch(userDataProvider);

    final bool hasCreatedABusiness = userData.hasCreatedABusiness ?? false;

    bool hasValidTermsAndPolicies =
        newDealsData.selectedTermsAndPolicy.isNotEmpty &&
            newDealsData.selectedTermsAndPolicy.any((document) =>
                (document.title != null && document.title != "") &&
                (document.doc != null ||
                    (document.content != null && document.content != "")));

    final isValid =
        (newDealsData.hasCreatedABussinessProfile || hasCreatedABusiness) &&
            hasValidTermsAndPolicies;

    return Expanded(
      child: SizedBox(
        height: 48,
        width: double.infinity,
        child: TextButton(
          onPressed: () => _isLoading
              ? null
              : (isValid)
                  ? _submit()
                  : null,
          style: TextButton.styleFrom(
            backgroundColor:
                isValid ? theme.primaryColor : _customColor.customD1D1D1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: _isLoading
              ? SizedBox(
                  height: 23,
                  width: 23,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                    strokeWidth: 3,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(theme.primaryColor),
                  ),
                )
              : const Text(
                  "Post deal",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
