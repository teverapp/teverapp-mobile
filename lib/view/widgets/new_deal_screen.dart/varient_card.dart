import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/general/common/custom_drop_down.dart';
import 'package:tever/view/widgets/general/common/custom_input_selection_button.dart';
import 'package:tever/view/widgets/general/common/show_color_buttom_sheet.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/add_images.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/material_button_sheet.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/select_size_buttom_sheet.dart';

class VarientCard extends ConsumerStatefulWidget {
  final Function? toggleVarient;

  final List<dynamic>? images;

  final int index;

  final double marginButtom;

  final bool hasExpanded;

  final String? color;

  final String? size;

  final String? material;

  final String? dimension;

  final String? weight;

  const VarientCard({
    super.key,
    this.toggleVarient,
    this.images,
    this.color,
    this.material,
    this.size,
    this.dimension,
    this.weight,
    required this.index,
    this.hasExpanded = true,
    this.marginButtom = 0,
  });

  @override
  ConsumerState<VarientCard> createState() => _VarientCardState();
}

class _VarientCardState extends ConsumerState<VarientCard> {
  File? _firstImage;

  File? _secondImage;

  File? _thirdImage;

  String? _selectedSize;

  String? _selectedMaterial;

  String? _selectedColor;

  final TextEditingController _dimensionController = TextEditingController();

  final TextEditingController _weightController = TextEditingController();

  void _selectColor(
      {required String value, required String id, String? imageUrl}) {
    setState(() {
      _selectedColor = value;
    });

    print("selected Color ${_selectedColor}");

    if (widget.toggleVarient != null) {
      _updateVariant();
    }
  }

  void _selectSize(
      {required String value, required String id, String? imageUrl}) {
    setState(() {
      _selectedSize = value;
    });

    if (widget.toggleVarient != null) {
      _updateVariant();
    }
  }

  void _selectMaterial(
      {required String value, required String id, String? imageUrl}) {
    setState(() {
      _selectedMaterial = value;
    });

    if (widget.toggleVarient != null) {
      _updateVariant();
    }
  }

  void _uploadImage(int imageIndex, File imageFile) async {
    switch (imageIndex) {
      case 0:
        setState(() {
          _firstImage = imageFile;
        });
        break;
      case 1:
        setState(() {
          _secondImage = imageFile;
        });
        break;
      case 2:
        setState(() {
          _thirdImage = imageFile;
        });
        break;
      default:
        print("Invalid image index: $imageIndex");
        break;
    }

    if (widget.toggleVarient != null) {
      _updateVariant();
    }
  }

  final CustomColors _customColor = const CustomColors();

  void _showColorBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return ShowColorButtomSheet(
            selectedColor: _selectedColor, selectColor: _selectColor);
      },
    );
  }

  void _showMaterialBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return MaterialButtonSheet(
            selectMaterial: _selectMaterial,
            selectedMaterial: _selectedMaterial);
      },
    );
  }

  void _showSizesBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return SelectSizeButtomSheet(
          selectSize: _selectSize,
          selectedSize: _selectedSize,
        );
      },
    );
  }

  void _showToast({required String message, required String status}) {
    if (mounted) {
      ToastService.showToast(
        context: context,
        message: message,
        status: status,
      );
    }
  }

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

  void _updateVariant() {
    final List<File?> images = [
      if (_firstImage != null) _firstImage,
      if (_secondImage != null) _secondImage,
      if (_thirdImage != null) _thirdImage,
    ];

    ref.read(newDealDataProvider.notifier).updateVarient(
        variantIndex: widget.index.toInt() - 1,
        varient: NewDeailsDetailsVarient(
          images: images,
          color: _selectedColor.toString(),
          size: _selectedSize.toString(),
          dimension: _dimensionController.text,
          material: _selectedMaterial.toString(),
          weight: _weightController.text,
        ));
  }

  void _saveVariant() {
    final validations = [
      {
        "condition":
            _firstImage == null && _secondImage == null && _thirdImage == null,
        "message": "Please select a variant image!"
      },
      {
        "condition": _selectedColor == null,
        "message": "Please select a variant color"
      },
      {
        "condition": _selectedSize == null,
        "message": "Please select a variant size"
      },
      {
        "condition": _dimensionController.text.isEmpty,
        "message": "Please input variant dimensions"
      },
      {
        "condition": _selectedMaterial == null,
        "message": "Please select variant material",
      },
      {
        "condition": _weightController.text.isEmpty,
        "message": "Please input variant weight"
      },
    ];

    for (var validation in validations) {
      if (validation["condition"] as bool) {
        _showToast(
            message: validation["message"].toString(),
            status: ToastStatus.error.name);

        return;
      }
    }

    final List<File?> images = [
      if (_firstImage != null) _firstImage,
      if (_secondImage != null) _secondImage,
      if (_thirdImage != null) _thirdImage,
    ];

    ref.read(newDealDataProvider.notifier).addVarient(
            varient: NewDeailsDetailsVarient(
          images: images,
          color: _selectedColor.toString(),
          size: _selectedSize.toString(),
          dimension: _dimensionController.text,
          material: _selectedMaterial.toString(),
          weight: _weightController.text,
        ));

    _closeVarient();

    _showToast(
        message: "Varient added sucessfully", status: ToastStatus.success.name);
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

    _selectedColor = widget.color ?? "";

    _selectedSize = widget.size ?? "";

    _selectedMaterial = widget.material ?? "";

    _dimensionController.text = widget.dimension ?? "";

    _weightController.text = widget.weight ?? "";
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

    print("widget.hasExpanded ${widget.hasExpanded}");

    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(
        bottom: widget.marginButtom,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
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
                  child: Image.asset(
                    widget.hasExpanded
                        ? "assets/icon/close_circle_slim.png"
                        : "assets/icon/arrow_down.png",
                    height: 20,
                    width: 20,
                  ))
            ],
          ),
          if (widget.hasExpanded) ...[
            const SizedBox(height: 16),
            AddImages(
              uploadImage: _uploadImage,
              firstImage: _firstImage,
              secondImage: _secondImage,
              thirdImage: _thirdImage,
            ),
            const SizedBox(height: 13),
            Text(
              "Colour",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 5),
            // CustomDropDown(
            //   dropDownHeight: 170,
            //   addCustomItemToList: true,
            //   addMoreItemsToList: _addMoreItemsToColorList,
            //   hasSelected: _selectedColor!.isNotEmpty,
            //   dropdownItems: _color,
            //   selectItem: _selectColor,
            //   selectedItem: _selectedColor!.isNotEmpty
            //       ? _selectedColor.toString()
            //       : "Select colour",
            // ),

            CustomInputSelectionButton(
              onTap: _showColorBottomSheet,
              hasSelected: _selectedColor!.isNotEmpty,
              selectedItem: _selectedColor!.isNotEmpty
                  ? _selectedColor.toString()
                  : "Select colour",
            ),
            const SizedBox(height: 13),
            Text(
              "Size",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 5),
            // CustomDropDown(
            //   dropDownHeight: 195,
            //   addCustomItemToList: true,
            //   addMoreItemsToList: _addMoreItemsToSizeList,
            //   hasSelected: _selectedSize!.isNotEmpty,
            //   dropdownItems: _size,
            //   selectItem: _selectSize,
            //   selectedItem: _selectedSize!.isNotEmpty
            //       ? _selectedSize.toString()
            //       : "Select size",
            // ),
            CustomInputSelectionButton(
              onTap: _showSizesBottomSheet,
              hasSelected: _selectedSize!.isNotEmpty,
              selectedItem: _selectedSize!.isNotEmpty
                  ? _selectedSize.toString()
                  : "Select size",
            ),
            const SizedBox(height: 13),
            Text(
              "Dimensions",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 5),
            TextField(
                controller: _dimensionController,
                style: TextStyle(
                  color: _customColor.custom242424,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: "Eg 40cm X 8cm X 15cm",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                  if (widget.toggleVarient != null) {
                    _updateVariant();
                  }
                }),
            const SizedBox(height: 13),
            Text(
              "Material",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 5),
            // CustomDropDown(
            //   dropDownHeight: 200,
            //   addCustomItemToList: true,
            //   addMoreItemsToList: _addMoreItemsToMaterialList,
            //   hasSelected: _selectedMaterial!.isNotEmpty,
            //   dropdownItems: _material,
            //   selectItem: _selectMaterial,
            //   selectedItem: _selectedMaterial!.isNotEmpty
            //       ? _selectedMaterial.toString()
            //       : "Select material",
            // ),
            CustomInputSelectionButton(
              onTap: _showMaterialBottomSheet,
              hasSelected: _selectedMaterial!.isNotEmpty,
              selectedItem: _selectedMaterial!.isNotEmpty
                  ? _selectedMaterial.toString()
                  : "Select material",
            ),
            const SizedBox(height: 13),
            Text(
              "Weight",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 5),
            Container(
              height: 48,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1,
                    color: _customColor.customEFEFEF,
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                        color: _customColor.custom242424,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter weight",
                        contentPadding:
                            const EdgeInsets.only(left: 16, bottom: 1),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _customColor.custom888888,
                        ),
                      ),
                      onChanged: (value) {
                        if (widget.toggleVarient != null) {
                          _updateVariant();
                        }
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 48,
                    width: 51,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                            width: 1, color: _customColor.customEFEFEF),
                      ),
                    ),
                    child: Text(
                      "Kg",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: _customColor.custom6B7280),
                    ),
                  ),
                ],
              ),
            )
          ],
          if (widget.toggleVarient == null) ...[
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: _saveVariant,
              child: Text(
                "Save variant",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.primaryColor),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
