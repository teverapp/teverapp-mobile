import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

import 'package:tever/extensions/toast_status.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/upload_file_button_sheet.dart';

class TermsAndPolicyCard extends ConsumerWidget {
  final String title;
  final String? fileName;
  final bool? hideBottomBorder;
  const TermsAndPolicyCard({
    super.key,
    required this.title,
    required this.fileName,
    this.hideBottomBorder = false,
  });

  final CustomColors _customColor = const CustomColors();

  void _deleteTermsAndPolicy({required WidgetRef ref}) {
    ref.read(newDealDataProvider.notifier).deleteTermsAndPolicy(title: title);
  }

  void _deleteTermsAndPolicyFile({required WidgetRef ref}) {
    ref
        .read(newDealDataProvider.notifier)
        .deleteTermsAndPolicyFile(title: title);
  }

  void _showAddFileButtonSheet({required BuildContext context}) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return UploadFileButtonSheet(title: title);
      },
    );
  }

  Widget _buildTypeCard(
      {required BuildContext context,
      required ThemeData theme,
      required String? label,
      required WidgetRef ref}) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _customColor.customEFEFEF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _showAddFileButtonSheet(context: context),
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon/file.png",
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label ?? "Upload file",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _customColor.custom6D6D6D,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (label != null)
            GestureDetector(
              onTap: () => _deleteTermsAndPolicyFile(ref: ref),
              child: Image.asset(
                "assets/icon/close-circle_red.png",
                height: 16,
                width: 16,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () => _deleteTermsAndPolicy(ref: ref),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom2E3438,
                ),
              ),
              Image.asset(
                "assets/icon/close-circle_red.png",
                height: 16,
                width: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildTypeCard(
            context: context, theme: theme, label: fileName, ref: ref),
        if (!hideBottomBorder!) const SizedBox(height: 7),
        if (!hideBottomBorder!)
          Divider(
            color: _customColor.customEFEFEF,
            thickness: 1,
          ),
        if (!hideBottomBorder!) const SizedBox(height: 4),
      ],
    );
  }
}
