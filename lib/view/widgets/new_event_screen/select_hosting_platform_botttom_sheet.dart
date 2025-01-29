import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/model/new_event.dart';

class SelectHostingPlatformBotttomSheet extends ConsumerWidget {
  const SelectHostingPlatformBotttomSheet({
    super.key,
  });

  final CustomColors _customColor = const CustomColors();

  void _selectHostingPlatform(
      {required WidgetRef ref,
      required BuildContext context,
      required CommonType value}) {
    ref
        .read(newEventDataProvider.notifier)
        .updateNewEvent("hostingPlatform", value);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: double.infinity,
        height: 290,
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
                "Hosting Platform",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _customColor.custom525252,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: hostingPlatform
                  .asMap()
                  .entries
                  .map(
                    (entry) => GestureDetector(
                      onTap: () => _selectHostingPlatform(
                        context: context,
                        ref: ref,
                        value: entry.value,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: hostingPlatform.length - 1 == entry.key
                                ? 0
                                : 16),
                        height: 48,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icon/${entry.value.imageUrl}",
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              entry.value.name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _customColor.custom242424),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ));
  }
}
