import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

class AddImageCard extends StatefulWidget {
  final VoidCallback uploadImage;
  final File? selectedImage;
  final EdgeInsetsGeometry padding;
  const AddImageCard(
      {super.key,
      required this.uploadImage,
      this.selectedImage,
      required this.padding});

  @override
  State<AddImageCard> createState() => _AddImageCardState();
}

class _AddImageCardState extends State<AddImageCard> {
  final CustomColors _customColor = const CustomColors();

  File? _selectedImage;

  @override
  void didUpdateWidget(covariant AddImageCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedImage != oldWidget.selectedImage) {
      setState(() {
        _selectedImage = widget.selectedImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    print("build called ${_selectedImage}");
    return GestureDetector(
      onTap: widget.uploadImage,
      child: Container(
        height: 136,
        alignment: Alignment.center,
        width: double.infinity,
        padding: widget.padding,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: _customColor.customEFEFEF,
            ),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _customColor.customFAFAFA,
          ),
          child: _selectedImage == null
              ? Image.asset(
                  "assets/icon/add_circle.png",
                  height: 24,
                  width: 24,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
        ),
      ),
    );
  }
}
