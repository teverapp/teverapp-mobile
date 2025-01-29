import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/model/new_event.dart';

class SelectEventTypeBottomSheet extends ConsumerWidget {
  const SelectEventTypeBottomSheet({
    super.key,
  });

  final CustomColors _customColor = const CustomColors();

  void _selectEventType(
      {required WidgetRef ref,
      required BuildContext context,
      required CommonType value}) {
    ref.read(newEventDataProvider.notifier).updateNewEvent("eventType", value);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 230,
        padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _customColor.custom6D6D6D,
                ),
              ),
            ),
            const SizedBox(height: 26),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Event Type",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _customColor.custom525252,
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectEventType(
                  context: context, ref: ref, value: newEventType[0]),
              child: SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon/people.png",
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      newEventType[0].name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _customColor.custom242424),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectEventType(
                  context: context, ref: ref, value: newEventType[1]),
              child: SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon/wifi.png",
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      newEventType[1].name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _customColor.custom242424),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
