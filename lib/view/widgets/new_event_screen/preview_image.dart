import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class PreviewImage extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback editImage;
  const PreviewImage({
    super.key,
    this.selectedImage,
    required this.editImage,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        height: 254,
        width: double.infinity,
        child: Stack(
          children: [
            if (selectedImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.file(
                  selectedImage!,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Positioned(
              right: 16,
              bottom: 24,
              child: GestureDetector(
                onTap: editImage,
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: _customColor.customFDF7ED),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icon/gallery_edit.png",
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
