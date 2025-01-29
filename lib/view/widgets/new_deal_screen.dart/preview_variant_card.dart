import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/general/common/custom_drop_down.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/add_images.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/check_and_confirm_card.dart';

class PreviewVariantCard extends ConsumerStatefulWidget {
  final Function? toggleVarient;

  final List<dynamic>? images;

  final int index;

  final bool hasExpanded;

  final String color;

  final String size;

  final String price;

  final String material;

  final String dimension;

  final String weight;

  const PreviewVariantCard({
    super.key,
    required this.toggleVarient,
    required this.images,
    required this.color,
    required this.material,
    required this.size,
    required this.dimension,
    required this.weight,
    required this.index,
    this.hasExpanded = true,
    required this.price,
  });

  @override
  ConsumerState<PreviewVariantCard> createState() => _PreviewVariantCardState();
}

class _PreviewVariantCardState extends ConsumerState<PreviewVariantCard> {
  File? _firstImage;

  File? _secondImage;

  File? _thirdImage;

  String? _selectedColor;

  String? _selectedSize;

  String? _selectedMaterial;

  final TextEditingController _dimensionController = TextEditingController();

  final TextEditingController _weightController = TextEditingController();

  final CustomColors _customColor = const CustomColors();

  void _closeVarient() {
    final newDealData = ref.read(newDealDataProvider);

    if (newDealData.varient.isEmpty) {
      ref
          .read(newDealDataProvider.notifier)
          .updateNewDeal("contactForQuote", false);
    }
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("showAddAVarientBtn", true);
  }

  @override
  void initState() {
    super.initState();
    _firstImage = (widget.images != null && widget.images!.isNotEmpty)
        ? widget.images![0]
        : null;

    _secondImage = (widget.images != null && widget.images!.length > 1)
        ? widget.images![1]
        : null;

    _thirdImage = (widget.images != null && widget.images!.length > 2)
        ? widget.images![2]
        : null;

    _selectedColor = widget.color;

    _selectedSize = widget.size;

    _selectedMaterial = widget.material;

    _dimensionController.text = widget.dimension;

    _weightController.text = widget.weight;
  }

  @override
  void dispose() {
    super.dispose();
    _dimensionController.dispose();

    _weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(bottom: 12, top: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: _customColor.customEFEFEF,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Variant ${widget.index}",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom4F4F4F),
              ),
              GestureDetector(
                onTap: () => widget.toggleVarient != null
                    ? widget.toggleVarient!(widget.index)
                    : _closeVarient(),
                child: AnimatedRotation(
                  turns: widget.hasExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Image.asset(
                    "assets/icon/drop_down.png",
                    height: 20,
                    width: 20,
                  ),
                ),

                // Image.asset(
                //   widget.hasExpanded
                //       ? "assets/icon/close_circle_slim.png"
                //       : "assets/icon/arrow_down.png",
                //   height: 20,
                //   width: 20,
                // )
              )
            ],
          ),
          if (widget.hasExpanded) ...[
            const SizedBox(height: 16),
            AddImages(
              padding: 0,
              imageTitleColor: theme.colorScheme.primary,
              borderColor: Colors.transparent,
              uploadImage: null,
              firstImage: _firstImage,
              secondImage: _secondImage,
              thirdImage: _thirdImage,
            ),
            const SizedBox(height: 3),
            Divider(
              color: _customColor.customEFEFEF,
              thickness: 1,
            ),
            CheckAndConfirmCard(label: "Shipping from", value: "Nigeria"),
            CheckAndConfirmCard(label: "Colour", value: widget.color),
            CheckAndConfirmCard(label: "Size", value: widget.size),
            CheckAndConfirmCard(label: "Dimensions", value: widget.dimension),
            CheckAndConfirmCard(label: "Material", value: widget.material),
            CheckAndConfirmCard(label: "Weight", value: widget.weight),
          ],
        ],
      ),
    );
  }
}
