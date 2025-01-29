import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/new_event_screen/choose_picture_type_dialog.dart';
import 'package:tever/view/widgets/new_event_screen/preview_image.dart';

class AddCoverImage extends ConsumerStatefulWidget {
  const AddCoverImage({super.key});

  @override
  ConsumerState<AddCoverImage> createState() => _AddCoverImageState();
}

class _AddCoverImageState extends ConsumerState<AddCoverImage> {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final newEventData = ref.watch(newEventDataProvider);

    return newEventData.coverImage != null
        ? PreviewImage(
            selectedImage: newEventData.coverImage as File,
            editImage: _selectImageTypeDialog)
        : Container(
            height: 260,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 47),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Container(
                constraints: const BoxConstraints(maxWidth: 264),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _customColor.customFDF7ED),
                      child: Image.asset(
                        "assets/icon/gallery_dark.png",
                        height: 24,
                        width: 24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Add cover image(s)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _customColor.custom242424,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Recommended size: 1200x800 pixels. Accepted formats: JPG, PNG.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: _customColor.custom242424),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: _customColor.customFDF7ED,
                          borderRadius: BorderRadius.circular(100)),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0)),
                        onPressed: _selectImageTypeDialog,
                        child: Text(
                          "Upload image",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: theme.primaryColor),
                        ),
                      ),
                    ),
                  ],
                )),
          );
  }
}
