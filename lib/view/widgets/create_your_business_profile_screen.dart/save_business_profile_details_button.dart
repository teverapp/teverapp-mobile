import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/business_profile.dart';
import 'package:tever/controller/input_validation_controller.dart';

import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/model/business_profile.dart';
import 'package:tever/model/new_event.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

class SaveBusinessProfileDetailsButton extends ConsumerWidget {
  final VoidCallback proceed;
  const SaveBusinessProfileDetailsButton({
    super.key,
    required this.proceed,
  });

  void _showToast({
    required String message,
    required String status,
    required BuildContext context,
  }) {
    ToastService.showToast(
      context: context,
      message: message,
      status: status,
    );
  }

  bool _validateCreateBusinessProfile({
    required BusinessProfile businessProfile,
    required BuildContext context,
  }) {
    final InputValidationController validate = InputValidationController();
    final sharedValidations = [
      {
        "condition": businessProfile.businessLogo == null,
        "message": "Please your business logo!"
      },
      {
        "condition": businessProfile.businessName.isEmpty,
        "message": "Please enter business name!"
      },
      {
        "condition": businessProfile.brandName.isEmpty,
        "message": "Please enter brand/trade name!"
      },
      {
        "condition": businessProfile.businessType == null,
        "message": "Please select business type!"
      },
      {
        "condition": businessProfile.industry == null,
        "message": "Please select industry!"
      },
      {
        "condition": businessProfile.aboutBusiness.isEmpty,
        "message": "About business cannot be empty!"
      },
      {
        "condition": businessProfile.email.isEmpty,
        "message": "Please input business email address!"
      },
      {
        "condition": businessProfile.emailHasError,
        "message": "Please input a valid business email address!"
      },
      {
        "condition": businessProfile.phoneNumber.isEmpty,
        "message": "Please input business phone number!"
      },
      {
        "condition": businessProfile.phoneNumberHasError,
        "message": "Please input a valid phone number!"
      },
      {
        "condition": businessProfile.address == null,
        "message": "Please input an address!"
      },
      {
        "condition":
            !validate.validateTikTokProfileUrl(businessProfile.tiktokUrl.name),
        "message": "Please enter a valid tiktok profile url"
      },
      {
        "condition": !validate
            .validateInstagramProfileUrl(businessProfile.instagramUrl.name),
        "message": "Please enter a valid instagram profile url"
      },
      {
        "condition": !validate
            .validateTwitterProfileUrl(businessProfile.twitterUrl.name),
        "message": "Please enter a valid twitter profile url!"
      },
      {
        "condition": !validate
            .validateThreadsProfileUrl(businessProfile.threadsUrl.name),
        "message": "Please enter a valid threads profile url!"
      },
      {
        "condition": !validate
            .validateFacebookProfileUrl(businessProfile.facebookUrl.name),
        "message": "Please enter a valid facebook profile url!"
      },
    ];

    for (var validation in sharedValidations) {
      if (validation["condition"] as bool) {
        _showToast(
          message: validation["message"].toString(),
          status: ToastStatus.error.name,
          context: context,
        );
        return false;
      }
    }
    return true;
  }

  void _continue({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final businessProfile = ref.watch(businessProfileProvider);

    if (!_validateCreateBusinessProfile(
        businessProfile: businessProfile, context: context)) {
      return;
    }

    proceed();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 56,
      width: double.infinity,
      child: TextButton(
        onPressed: () => _continue(context: context, ref: ref),
        style: TextButton.styleFrom(
          backgroundColor: theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: const Text(
          "Save details",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
