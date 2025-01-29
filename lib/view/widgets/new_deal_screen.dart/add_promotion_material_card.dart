import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/add_image_card.dart';
import 'package:tever/view/widgets/new_event_screen/choose_picture_type_dialog.dart';

class AddPromotionMaterialCard extends ConsumerStatefulWidget {
  final VoidCallback close;
  const AddPromotionMaterialCard({
    super.key,
    required this.close,
  });

  @override
  ConsumerState<AddPromotionMaterialCard> createState() =>
      _AddPromotionMaterialCardState();
}

class _AddPromotionMaterialCardState
    extends ConsumerState<AddPromotionMaterialCard> {
  final CustomColors _customColor = const CustomColors();

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

  void _pickImage(File imageFile) {
    ref.read(newDealDataProvider.notifier).updateNewDeal("dpmi", imageFile);
  }

  @override
  Widget build(BuildContext context) {
    final newDealData = ref.watch(newDealDataProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: _customColor.customDCDCDC,
          ),
          bottom: BorderSide(
            width: 1,
            color: _customColor.customDCDCDC,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Promotion material",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom242424,
                ),
              ),
              GestureDetector(
                onTap: widget.close,
                child: Image.asset(
                  "assets/icon/close_circle.png",
                  height: 20,
                  width: 20,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          AddImageCard(
            uploadImage: _selectImageTypeDialog,
            selectedImage: newDealData.dealPromotionMaterialImage,
            padding: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}
