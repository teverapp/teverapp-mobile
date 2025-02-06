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

class TermsAndPolicyCard extends ConsumerStatefulWidget {
  final String title;
  final String content;
  final File? docFile;
  final String id;
  final String? fileName;
  final bool? hideBottomBorder;
  const TermsAndPolicyCard({
    super.key,
    required this.title,
    required this.fileName,
    required this.content,
    required this.docFile,
    required this.id,
    this.hideBottomBorder = false,
  });

  @override
  ConsumerState<TermsAndPolicyCard> createState() => _TermsAndPolicyCardState();
}

class _TermsAndPolicyCardState extends ConsumerState<TermsAndPolicyCard> {
  bool _selectedContentForAddingPolicyType = false;

  final TextEditingController _contentController = TextEditingController();

  final CustomColors _customColor = const CustomColors();

  void _showContentInput() {
    setState(() {
      _selectedContentForAddingPolicyType = true;
      // _selectedContentForAddingPolicyType = true;
    });
  }

  void _deleteTermsAndPolicy() {
    ref
        .read(newDealDataProvider.notifier)
        .deleteTermsAndPolicy(title: widget.title);
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
        return UploadFileButtonSheet(title: widget.title, id: widget.id);
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _selectedContentForAddingPolicyType = widget.content.isNotEmpty;

    _contentController.text = widget.content;
  }

  @override
  void didUpdateWidget(covariant TermsAndPolicyCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if (widget.content != oldWidget.content) {
    setState(() {
      _selectedContentForAddingPolicyType = widget.content.isNotEmpty;
      print(
          "updatedSelectedTermsAndPolicy updateaaaa ==> $_selectedContentForAddingPolicyType");
    });
    // }
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newDealsData = ref.watch(newDealDataProvider);

    // _selectedContentForAddingPolicyType = widget.content.isNotEmpty;

    final showContainer = (widget.content.isEmpty) &&
        (widget.docFile == null) &&
        (!_selectedContentForAddingPolicyType);

    print(
        "updatedSelectedTermsAndPolicy build ==> $_selectedContentForAddingPolicyType");

    return Column(
      children: [
        GestureDetector(
          onTap: _deleteTermsAndPolicy,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
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
        if (showContainer)
          Container(
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
                          GestureDetector(
                            onTap: _showContentInput,
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icon/file.png",
                                  height: 16,
                                  width: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Enter content directly",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: _customColor.custom6D6D6D,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "or",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _customColor.custom6D6D6D,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () =>
                                  _showAddFileButtonSheet(context: context),
                              child: Container(
                                margin: const EdgeInsets.only(right: 30),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icon/file.png",
                                      height: 16,
                                      width: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Upload file",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: _customColor.custom6D6D6D,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (widget.docFile != null) ...[
          const SizedBox(height: 2),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _customColor.customEFEFEF),
            child: Row(
              children: [
                Image.asset(
                  "assets/icon/file.png",
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.fileName.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom6D6D6D,
                  ),
                ),
              ],
            ),
          ),
        ],

        if (_selectedContentForAddingPolicyType) ...[
          const SizedBox(height: 2),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Content",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 120,
            child: TextField(
              controller: _contentController,
              style: TextStyle(
                color: _customColor.custom242424,
                fontSize: 14,
              ),
              maxLines: null,
              minLines: 5,
              decoration: InputDecoration(
                hintText: "Enter Content",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.only(
                    left: 16, top: 10, right: 16, bottom: 10),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _customColor.customEFEFEF,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _customColor.customEFEFEF,
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _customColor.customEFEFEF,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1),
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom888888,
                ),
              ),
              onChanged: (value) {
                final selectedFile = DocumentFile(
                  content: value,
                  title: widget.title,
                  id: widget.id,
                );

                ref.read(newDealDataProvider.notifier).updateTermsAndPolicy(
                      termsAndPolicy: selectedFile,
                    );
              },
            ),
          ),
        ],
        // _buildTypeCard(
        //     context: context, theme: theme, label: fileName, ref: ref),
        if (!widget.hideBottomBorder!) const SizedBox(height: 7),
        if (!widget.hideBottomBorder!)
          Divider(
            color: _customColor.customEFEFEF,
            thickness: 1,
          ),
        if (!widget.hideBottomBorder!) const SizedBox(height: 4),
      ],
    );
  }
}
