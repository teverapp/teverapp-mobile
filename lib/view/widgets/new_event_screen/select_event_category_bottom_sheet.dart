import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/model/new_event.dart';

class SelectEventCategoryBottomSheet extends ConsumerWidget {
  const SelectEventCategoryBottomSheet({
    super.key,
  });

  final CustomColors _customColor = const CustomColors();

  void _selectTimeZone(
      {required WidgetRef ref,
      required BuildContext context,
      required CommonType value}) {
    ref
        .read(newEventDataProvider.notifier)
        .updateNewEvent("eventCategory", value);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 330,
        padding: const EdgeInsets.only(top: 17, left: 12, right: 12),
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
                "Event Category",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _customColor.custom525252,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 16,
                spacing: 8,
                children: eventCategories
                    .map(
                      (eventCategory) => GestureDetector(
                        onTap: () => _selectTimeZone(
                            context: context, ref: ref, value: eventCategory),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                width: 1, color: _customColor.customB0B0B0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/icon/${eventCategory.imageUrl}",
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                eventCategory.name.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: _customColor.custom5D5D5D),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList())
          ],
        ),
      ),
    );
  }
}
