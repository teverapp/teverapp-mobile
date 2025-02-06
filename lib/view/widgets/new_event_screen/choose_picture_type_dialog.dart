import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

class ChoosePictureTypeDialog extends StatefulWidget {
  final Function uploadImage;
  const ChoosePictureTypeDialog({super.key, required this.uploadImage});

  @override
  State<ChoosePictureTypeDialog> createState() =>
      _ChoosePictureTypeDialogState();
}

class _ChoosePictureTypeDialogState extends State<ChoosePictureTypeDialog> {
  final CustomColors _customColor = const CustomColors();

  bool _hasStartedPickingImage = false;

  void _showToast({required String message, required String status}) {
    if (mounted) {
      ToastService.showToast(
        context: context,
        message: message,
        status: status,
      );
    }
  }

  Future<void> _pickImageFromDevice({required bool pickFromGallery}) async {
    try {
      if (!_hasStartedPickingImage) {
        _hasStartedPickingImage = true;

        if (Platform.isIOS) {
          Permission photoPermission = Permission.photos;

          Permission cameraPermission = Permission.camera;

          final photoPermissionStatus = await photoPermission.request();

          final cameraPermissionStatus = await cameraPermission.request();

          if (photoPermissionStatus.isDenied ||
              photoPermissionStatus.isPermanentlyDenied ||
              cameraPermissionStatus.isDenied ||
              cameraPermissionStatus.isPermanentlyDenied) {
            _showToast(
              message:
                  "Access is denied. Please allow access in device settings.",
              status: ToastStatus.error.name,
            );
            return;
          }
        }

        final pickedImage = await ImagePicker().pickImage(
            source: pickFromGallery ? ImageSource.gallery : ImageSource.camera);

        if (pickedImage == null) return;

        final allowedExtensions = ['png', 'jpg'];

        final fileExtension = pickedImage.path.split('.').last.toLowerCase();

        if (!allowedExtensions.contains(fileExtension)) {
          _showToast(
            message: "Please select a valid image file (PNG or JPG).",
            status: ToastStatus.error.name,
          );
          return;
        }

        final imageFile = File(pickedImage.path);

        widget.uploadImage(imageFile);

        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    } catch (error) {
      _showToast(
        message: "Something went wrong. Please try again.",
        status: ToastStatus.error.name,
      );
    } finally {
      _hasStartedPickingImage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
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
              const SizedBox(height: 30),
              Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: _customColor.customRgba2,
                        offset: const Offset(0, 1),
                        blurRadius: 3,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: _customColor.customRgba3,
                        offset: const Offset(0, 0),
                        blurRadius: 1,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(children: [
                    GestureDetector(
                      onTap: () => _pickImageFromDevice(pickFromGallery: false),
                      child: Container(
                        color: Colors.transparent,
                        height: 36,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icon/camera_orange.png",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Upload from Camera",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: _customColor.custom5D5D5D),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                        onTap: () =>
                            _pickImageFromDevice(pickFromGallery: true),
                        child: Container(
                          color: Colors.transparent,
                          height: 36,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icon/gallery.png",
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Upload from Gallery",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: _customColor.custom5D5D5D),
                              )
                            ],
                          ),
                        )),
                  ]))
            ]));
  }
}
