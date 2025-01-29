import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:tever/controller/new_event_controlller.dart";
import "package:tever/helpers/custom_colors.dart";

class SelectTimeZoneBottomSheet extends ConsumerWidget {
  const SelectTimeZoneBottomSheet({
    super.key,
  });

  final CustomColors _customColor = const CustomColors();

  final List<String> _timeZone = const [
    "Baker Island Time (UTC-12)",
    "Samoa Time (UTC-11)",
    "Hawaii-Aleutian Time (UTC-10)",
    "Alaska Time (UTC-9)",
    "Pacific Time (UTC-8)",
    "Mountain Time (UTC-7)",
    "Central Time (UTC-6)",
    "Eastern Time (UTC-5)",
    "Atlantic Time (UTC-4)",
    "West Africa Time (UTC-3)",
    "Mid-Atlantic Time (UTC-2)",
    "Greenwich Mean Time -1 (UTC-1)",
    "Greenwich Mean Time (UTC+0)",
    "Central European Time (UTC+1)",
    "Eastern European Time (UTC+2)",
    "Moscow Time (UTC+3)",
    "Astrakhan Time (UTC+4)",
    "Pakistan Time (UTC+5)",
    "Bangladesh Time (UTC+6)",
    "Krasnoyarsk Time (UTC+7)",
    "China Standard Time (UTC+8)",
    "Japan Standard Time (UTC+9)",
    "Australian Western Standard Time (UTC+10)",
    "Kiribati Time (UTC+12)",
  ];

  void _selectTimeZone(
      {required WidgetRef ref,
      required BuildContext context,
      required String value}) {
    ref.read(newEventDataProvider.notifier).updateNewEvent("timeZone", value);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context).size;

    final height = mediaQuery.height * 0.6;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text(
              "Timezone",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _customColor.custom525252,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children: _timeZone
                        .asMap()
                        .entries
                        .map(
                          (entry) => GestureDetector(
                              onTap: () => _selectTimeZone(
                                  context: context,
                                  ref: ref,
                                  value: entry.value),
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                color: Colors.transparent,
                                margin: const EdgeInsets.only(bottom: 13),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icon/global.png",
                                      height: 16,
                                      width: 16,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      entry.value,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _customColor.custom242424),
                                    )
                                  ],
                                ),
                              )),
                        )
                        .toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
