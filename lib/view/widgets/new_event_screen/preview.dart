import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_event.dart';
import 'package:tever/view/widgets/general/common/current_location.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/check_and_confirm.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_form.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/set_terms.dart';
import 'package:tever/view/widgets/new_event_screen/add_cover_image.dart';
import 'package:tever/view/widgets/new_event_screen/choose_picture_type_dialog.dart';
import 'package:tever/view/widgets/new_event_screen/free_ticket_tier.dart';
import 'package:tever/view/widgets/new_event_screen/new_event_form.dart';
import 'package:tever/view/widgets/new_event_screen/paid_ticket_tier.dart';
import 'package:tever/view/widgets/new_event_screen/preview_description.dart';
import 'package:tever/view/widgets/new_event_screen/location_and_timing.dart';
import 'package:tever/view/widgets/new_event_screen/preview_image.dart';
import 'package:tever/view/widgets/new_event_screen/publish_event_dialog.dart';
import 'package:tever/view/widgets/new_event_screen/tags.dart';
import 'package:tever/view/widgets/new_event_screen/tickets.dart';

class Preview extends ConsumerStatefulWidget {
  const Preview({super.key});

  @override
  ConsumerState<Preview> createState() => _PreviewState();
}

class _PreviewState extends ConsumerState<Preview> {
  final CustomColors _customColor = const CustomColors();

  void _pickImage(File pickedImage) async {
    ref
        .read(newEventDataProvider.notifier)
        .updateNewEvent("coverimage", pickedImage);
  }

  void _selectImageTypeDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return ChoosePictureTypeDialog(
          uploadImage: _pickImage,
        );
      },
    );
  }

  void _confirmPublish({required BuildContext context}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "",
        transitionDuration: const Duration(microseconds: 200000),
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox.shrink();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: const PublishEventDialog());
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final newEventData = ref.watch(newEventDataProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
        child: Column(
          children: [
            PreviewImage(
              editImage: _selectImageTypeDialog,
              selectedImage: newEventData.coverImage,
            ),
            const SizedBox(height: 18),
            PreviewDescription(
              edit: () {},
              title: newEventData.eventName,
              description: newEventData.description,
              useFullRadius:
                  newEventData.eventType!.name == newEventType[1].name,
            ),
            if (newEventData.eventType!.name == newEventType[1].name)
              const SizedBox(height: 18),
            if (newEventData.eventType!.name == newEventType[0].name)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.white,
                child: Divider(
                  color: _customColor.customEFEFEF,
                  thickness: 1,
                ),
              ),
            LocationAndTiming(
              useFullRadius:
                  newEventData.eventType!.name == newEventType[1].name,
            ),
            const SizedBox(height: 18),
            if (newEventData.eventType!.name == newEventType[1].name &&
                newEventData.eventCategory != null) ...[
              Tags(
                title: newEventData.eventCategory!.name,
                imageUrl: newEventData.eventCategory!.imageUrl!,
              ),
              const SizedBox(height: 18)
            ],
            Tickets(),
            const SizedBox(height: 40),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: TextButton(
                onPressed: () => _confirmPublish(context: context),
                style: TextButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  "Publish",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
