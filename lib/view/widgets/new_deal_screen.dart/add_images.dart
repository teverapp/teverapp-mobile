import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_event_screen/choose_picture_type_dialog.dart';

class AddImages extends StatefulWidget {
  final Function? uploadImage;
  final File? firstImage;
  final File? secondImage;
  final File? thirdImage;
  final double? padding;
  final Color? imageTitleColor;
  final Color? borderColor;
  const AddImages({
    super.key,
    required this.uploadImage,
    this.firstImage,
    this.secondImage,
    this.thirdImage,
    this.imageTitleColor,
    this.padding,
    this.borderColor,
  });

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  final CustomColors _customColor = const CustomColors();

  int _selectedImageIndex = 0;

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

  void _pickImage(File pickedImage) async {
    if (widget.uploadImage != null) {
      widget.uploadImage!(_selectedImageIndex, pickedImage);
    }
  }

  Widget _buildImageAddCard({required File? image, required int imageIndex}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _selectedImageIndex = imageIndex;
          _selectImageTypeDialog();
        },
        child: Container(
          height: 88,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.uploadImage == null
                  ? Colors.transparent
                  : _customColor.customFAFAFA,
              borderRadius: BorderRadius.circular(8)),
          child: (widget.uploadImage == null && image == null)
              ? const SizedBox.shrink()
              : image == null
                  ? Image.asset(
                      "assets/icon/add_circle.png",
                      height: 24,
                      width: 24,
                    )
                  : ClipRRect(
                      borderRadius:
                          BorderRadius.circular(8), // Match container's radius
                      child: Image.file(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Images",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: widget.imageTitleColor ?? _customColor.custom242424,
            )),
        const SizedBox(height: 5),
        Container(
          padding: EdgeInsets.all(widget.padding ?? 8),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: widget.borderColor ?? _customColor.customEFEFEF,
              ),
              color: widget.uploadImage == null
                  ? Colors.transparent
                  : Colors.white,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              _buildImageAddCard(imageIndex: 0, image: widget.firstImage),
              const SizedBox(width: 8),
              _buildImageAddCard(
                imageIndex: 1,
                image: widget.secondImage,
              ),
              const SizedBox(width: 8),
              _buildImageAddCard(
                imageIndex: 2,
                image: widget.thirdImage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
