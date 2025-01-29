import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/input_validation_controller.dart';

import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/model/new_event.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

class NewEventContinueButton extends ConsumerWidget {
  final String? type;
  final Function proceed;
  const NewEventContinueButton({
    super.key,
    required this.type,
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

  bool _validateSharedFields({
    required NewEvent newEventData,
    required BuildContext context,
  }) {
    final sharedValidations = [
      {
        "condition": newEventData.coverImage == null,
        "message": "Please select a cover image!"
      },
      {
        "condition": newEventData.eventName.isEmpty,
        "message": "Please enter event name!"
      },
      {
        "condition": newEventData.description.isEmpty,
        "message": "Please enter event description!"
      },
      {
        "condition": newEventData.timeZone == null,
        "message": "Please select time zone!"
      },
      {
        "condition": newEventData.startTimeAndDate.isEmpty,
        "message": "Please enter start time and date!"
      },
      {
        "condition": newEventData.endTimeAndDate.isEmpty,
        "message": "Please enter end time and date!"
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

  bool _validateVirtualEvent({
    required NewEvent newEventData,
    required BuildContext context,
  }) {
    final InputValidationController validate = InputValidationController();

    final virtualValidations = [
      {
        "condition": newEventData.hostingPlatform == null,
        "message": "Please select hosting platform!"
      },
      {
        "condition": !validate.isValidUrl(newEventData.eventLink),
        "message": "Please enter a valid event link!",
      },
    ];

    for (var validation in virtualValidations) {
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
    required String? type,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final newEventData = ref.watch(newEventDataProvider);

    if (newEventData.eventType == null) {
      _showToast(
        message: "Please select event type!",
        status: ToastStatus.error.name,
        context: context,
      );
      return;
    }

    if (!_validateSharedFields(newEventData: newEventData, context: context)) {
      return;
    }

    if (type == newEventType[1].name) {
      if (!_validateVirtualEvent(
          newEventData: newEventData, context: context)) {
        return;
      }
    }

    proceed(1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: 48,
          width: double.infinity,
          child: TextButton(
            onPressed: () => _continue(context: context, ref: ref, type: type),
            style: TextButton.styleFrom(
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text(
              "Continue",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
