import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/helpers/custom_colors.dart';

class EventLocationBottomSheet extends ConsumerWidget {
  const EventLocationBottomSheet({
    super.key,
  });

  final CustomColors _customColor = const CustomColors();

  void _selectEventLocation(
      {required WidgetRef ref,
      required BuildContext context,
      required String value}) {
    ref
        .read(newEventDataProvider.notifier)
        .updateNewEvent("addressOfEvent", value);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context).size;

    final theme = Theme.of(context);

    final height = mediaQuery.height * 0.9;

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
                "Event Location",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _customColor.custom525252,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              style: TextStyle(
                color: _customColor.custom242424,
                fontSize: 14,
              ),
              autofocus: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(16),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: 1,
                  ),
                ),
                prefixIconConstraints:
                    const BoxConstraints(maxHeight: 150, maxWidth: 150),
                prefixIcon: Container(
                  margin: const EdgeInsets.only(left: 16, right: 8),
                  child: Image.asset(
                    "assets/icon/location_orange.png",
                    height: 16,
                    width: 16,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _customColor.customEFEFEF,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1),
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom888888,
                ),
              ),
              onChanged: (value) async {},
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => _selectEventLocation(
                  context: context, ref: ref, value: "My address test"),
              child: Container(
                height: 51.5,
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: Image.asset(
                          "assets/icon/location_gray.png",
                          height: 24,
                          width: 24,
                        )),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "58. Aibu Street, Surulere",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _customColor.custom242424),
                        ),
                        const SizedBox(height: 1.5),
                        Text(
                          "Lagos, Nigeria",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: _customColor.customB0B0B0),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
