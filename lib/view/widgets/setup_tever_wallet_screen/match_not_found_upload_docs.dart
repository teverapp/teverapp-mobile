import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/add_image_card.dart';
import 'package:tever/view/widgets/new_event_screen/choose_picture_type_dialog.dart';

class MatchNotFoundUploadDocs extends StatelessWidget {
  const MatchNotFoundUploadDocs({super.key});

  final CustomColors _customColor = const CustomColors();

  void _selectImageTypeDialog(BuildContext context) {
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

  void _pickImage(File pickedImage) async {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Image.asset("assets/icon/alert_triangle.png",
                  height: 80, width: 80),
              const SizedBox(height: 24),
              Text(
                "Match not found",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom242424),
              ),
              const SizedBox(height: 8),
              Text(
                "We are unable to verify your identity as there is no matching record found on the NIMC’s databank. Please ensure to enter accurate information and try again.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _customColor.custom242424),
              ),
              const SizedBox(height: 32),
              Divider(color: _customColor.customEFEFEF),
              const SizedBox(height: 24),
              Text(
                "Upload document",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _customColor.custom242424),
              ),
              const SizedBox(height: 16),
              AddImageCard(
                uploadImage: () => _selectImageTypeDialog(context),
                padding: const EdgeInsets.symmetric(vertical: 8),
              )
            ],
          ),
        ),
        const SizedBox(height: 64),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _customColor.custom888888, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              "Verify me",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _customColor.custom888888,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
