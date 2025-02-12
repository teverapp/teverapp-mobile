import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/input_validation_controller.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/screens/tabs_screen.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

class SaveAsDraftButton extends ConsumerStatefulWidget {
  const SaveAsDraftButton({super.key});

  @override
  ConsumerState<SaveAsDraftButton> createState() => _SaveAsDraftButtonState();
}

class _SaveAsDraftButtonState extends ConsumerState<SaveAsDraftButton> {
  bool _isLoading = false;

  void _navigateToSignInScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  void _navigate(Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
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

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await ref
          .read(newDealDataProvider.notifier)
          .uploadDeal(saveToDraft: true);

      _navigate(const TabsScreen(refetchUserData: true));

      _showToast(
          message: "Deals saved draft successfully",
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

  bool _validateSaveAsDraft({required NewDeal newDeal}) {
    final InputValidationController validate = InputValidationController();
    final sharedValidations = [
      {
        "condition": newDeal.title == null || newDeal.title == "",
        "message": "Details title is required!"
      },
      {
        "condition": newDeal.category == null,
        "message": "Details category is required!"
      },
      {
        "condition": newDeal.subCategory == null || newDeal.subCategory == "",
        "message": "Details sub category is required!"
      },
      {
        "condition": newDeal.dealPromotionType == null,
        "message": "Promotion type is required!"
      },
      {
        "condition": newDeal.dealPromotionValue == null ||
            newDeal.dealPromotionValue == "",
        "message": "Promotion value is required!"
      },
      {
        "condition": !validate
            .validateOnlyNumbers(newDeal.dealPromotionValue.toString()),
        "message": "Promotion value has to be a number!"
      },
      {
        "condition": newDeal.dealPromotionCode == null ||
            newDeal.dealPromotionCode == "",
        "message": "Promotion code is required!"
      },
      {
        "condition":
            !validate.validateOnlyNumbers(newDeal.dealPromotionCode.toString()),
        "message": "Promotion code has to be a number!"
      },
      {
        "condition": newDeal.dealPromotionValidDate == null,
        "message": "Promotion date is required!"
      },
    ];

    for (var validation in sharedValidations) {
      if (validation["condition"] as bool) {
        _showToast(
          message: validation["message"].toString(),
          status: ToastStatus.error.name,
        );
        return false;
      }
    }
    return true;
  }

  void _continue() {
    final newDeal = ref.watch(newDealDataProvider);

    if (!_validateSaveAsDraft(newDeal: newDeal)) {
      return;
    }

    _submit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: SizedBox(
        height: 48,
        child: OutlinedButton(
          onPressed: _continue,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(
              color: theme.colorScheme.error,
              width: 1,
            ),
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
                        AlwaysStoppedAnimation<Color>(theme.colorScheme.error),
                  ),
                )
              : Text(
                  "Save as draft",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.error,
                  ),
                ),
        ),
      ),
    );
  }
}
