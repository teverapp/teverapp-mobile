import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/model/new_event.dart';

class SaveAsDraftButtomSheet extends ConsumerWidget {
  final VoidCallback popScreen;
  const SaveAsDraftButtomSheet({
    super.key,
    required this.popScreen,
  });

  final CustomColors _customColor = const CustomColors();

  void _discard({required WidgetRef ref, required BuildContext context}) {
    ref.read(newEventDataProvider.notifier).resetEvent();

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }

    popScreen();
  }

  void _saveAsDraft({required WidgetRef ref, required BuildContext context}) {
    ref.read(newEventDataProvider.notifier).resetEvent();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 294,
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
            const Spacer(),
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  color: _customColor.customFDF7ED, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/icon/note_orange.png",
                height: 16,
                width: 16,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              "Save as Draft",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(
                "Before you leave, would you like to save your progress so you can return to it later.",
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _customColor.custom888888),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                  width: 90,
                  child: TextButton(
                    onPressed: () => _discard(context: context, ref: ref),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      "Discard",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _customColor.custom292929,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  width: 132,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      "Save as draft",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
