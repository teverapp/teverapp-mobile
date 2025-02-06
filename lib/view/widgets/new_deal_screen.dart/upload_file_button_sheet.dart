import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

class UploadFileButtonSheet extends ConsumerStatefulWidget {
  final String title;
  final String id;
  const UploadFileButtonSheet({
    super.key,
    required this.title,
    required this.id,
  });

  @override
  ConsumerState<UploadFileButtonSheet> createState() =>
      _UploadFileButtonSheetState();
}

class _UploadFileButtonSheetState extends ConsumerState<UploadFileButtonSheet> {
  final CustomColors _customColor = const CustomColors();

  void _showToast({
    required String message,
    required String status,
    required BuildContext context,
  }) {
    ToastService.showToast(
      context: context,
      message: message,
      status: status,
    );
  }

  Future<void> _selectDocument() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'], // Restrict selection to these types
      );

      if (result != null) {
        final fileExtension = result.files.first.extension?.toLowerCase();
        final fileSize = result.files.first.size;
        const maxFileSize = 5 * 1024 * 1024; // 5 MB

        // Validate file type
        if (fileExtension != 'pdf' && fileExtension != 'docx') {
          if (mounted) {
            _showToast(
              context: context,
              message: "Please upload a file of type PDF or DOCX.",
              status: ToastStatus.error.name,
            );
          }
          return;
        }

        // Validate file size
        if (fileSize > maxFileSize) {
          if (mounted) {
            _showToast(
              context: context,
              message: "The file size must be less than 5MB.",
              status: ToastStatus.error.name,
            );
          }
          return;
        }

        // Process valid file
        final selectedFile = DocumentFile(
          title: widget.title,
          docName: result.files.single.name,
          id: widget.id,
          doc: File(result.files.single.path!),
        );

        ref.read(newDealDataProvider.notifier).updateTermsAndPolicy(
              termsAndPolicy: selectedFile,
            );
      }
    } catch (e) {
      if (mounted) {
        _showToast(
          context: context,
          message: "Something went wrong. Please try again.",
          status: ToastStatus.error.name,
        );
      }
    } finally {
      if (mounted) {
        if (ModalRoute.of(context)?.isCurrent == true) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 211,
        padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: _customColor.custom6D6D6D,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Upload file",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Anybody",
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 12),
            Container(
              height: 64,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 1, color: _customColor.customEFEFEF),
              ),
              child: GestureDetector(
                onTap: _selectDocument,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icon/file_gray.png",
                        height: 24, width: 24),
                    const SizedBox(width: 8),
                    Text(
                      "Add file",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _customColor.custom242424,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Format and size supported: .docx, pdf, txt; 5mb",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom8939EE),
            )
          ],
        ),
      ),
    );
  }
}
