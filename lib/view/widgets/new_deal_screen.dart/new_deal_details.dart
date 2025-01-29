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
import 'package:tever/view/widgets/new_deal_screen.dart/new_deals_category_bottom_sheet.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deals_subcategory_bottom_sheet.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/add_images.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/space_location_card.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/switch_button_outlined.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/varient_card.dart';

class NewDealDetails extends ConsumerStatefulWidget {
  final int selectedIndex;
  final VoidCallback newDealDetailsResize;
  const NewDealDetails(
      {super.key,
      required this.selectedIndex,
      required this.newDealDetailsResize});

  @override
  ConsumerState<NewDealDetails> createState() => _NewDealDetailsState();
}

class _NewDealDetailsState extends ConsumerState<NewDealDetails> {
  final CustomColors _customColor = const CustomColors();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _capacityController = TextEditingController();

  final TextEditingController _dimensionController = TextEditingController();

  String? _dealSubCategoryListErrorMessage;

  bool _dealSubCategoryListIsLoading = false;

  int _selectedVarient = -1;

  void _resizeVarient(int value) {
    print("_resizeVarient $value");
    setState(() {
      _selectedVarient = value == _selectedVarient ? -1 : value;
    });
  }

  void _uploadImage(int imageIndex, File imageFile) async {
    ref.read(newDealDataProvider.notifier).uploadDealDetailsImages(
          imageIndex: imageIndex,
          image: imageFile,
        );
  }

  // void _selectCategory(
  //     {required String value, required String id, String? imageUrl}) {
  //   ref.read(newDealDataProvider.notifier).updateNewDeal("categoryId", id);

  //   ref.read(newDealDataProvider.notifier).updateNewDeal("category", value);
  // }

  void _selectNoOfRoomsForCleaning(
      {required String value, required String id, String? imageUrl}) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("noOfRoomsForCleaning", value);
  }

  void _selectDuration(
      {required String value, required String id, String? imageUrl}) {
    ref.read(newDealDataProvider.notifier).updateNewDeal("duration", value);
  }

  void _toggleContactForQuote() {
    final newDealData = ref.watch(newDealDataProvider);
    print("Clicked: ${newDealData.contactForQuote}");

    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("contactForQuote", !newDealData.contactForQuote);
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

  void _showCategoryBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const NewDealsCategoryBottomSheet();
      },
    );
  }

  void _showSubCategoryBottomSheet() {
    final newDealData = ref.watch(newDealDataProvider);

    if (newDealData.categoryId == null) {
      _showToast(
          message: "Please select category!", status: ToastStatus.error.name);

      return;
    }
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const NewDealsSubcategoryBottomSheet();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _priceController.dispose();

    _descriptionController.dispose();

    _titleController.dispose();

    _capacityController.dispose();

    _dimensionController.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newDealData = ref.watch(newDealDataProvider);

      _priceController.text = newDealData.price ?? "";

      _descriptionController.text = newDealData.description ?? "";

      _titleController.text = newDealData.title ?? "";

      _capacityController.text = newDealData.capacity ?? "";

      _dimensionController.text = newDealData.dimension ?? "";

      // if (newDealData.dealDetailsCategory.isEmpty) {
      //   _fetchDealCategoryList();
      // }

      // if (newDealData.dealDetailsSubCategory.isEmpty) {
      //   _fetchDealSubCategoryList();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final newDealData = ref.watch(newDealDataProvider);

    final showQuote = newDealData.type!.name == dealTypeDropdownItems[0].name
        ? (newDealData.varient.isNotEmpty || !newDealData.showAddAVarientBtn)
        : newDealData.type!.name == dealTypeDropdownItems[1].name
            ? true
            : false;

    final showPrice = (newDealData.type!.name ==
                dealTypeDropdownItems[0].name ||
            newDealData.type!.name == dealTypeDropdownItems[2].name)
        ? (newDealData.varient.isNotEmpty && !newDealData.contactForQuote) ||
            (!newDealData.showAddAVarientBtn && !newDealData.contactForQuote) ||
            newDealData.type!.name == dealTypeDropdownItems[2].name
        : newDealData.type!.name == dealTypeDropdownItems[1].name
            ? (!newDealData.contactForQuote)
            : false;

    return Container(
      padding: EdgeInsets.only(
          bottom: widget.selectedIndex == 1 ? 16.0 : 10, left: 16, right: 16),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: _customColor.customEFEFEF))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.newDealDetailsResize,
            child: Container(
              height: 38,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //selectedIndex == 0 ? 0.5 : 0
                children: [
                  Row(
                    children: [
                      Image.asset(
                        widget.selectedIndex == 1
                            ? "assets/icon/minus_circle.png"
                            : "assets/icon/add_circle_dark.png",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _customColor.custom242424,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (widget.selectedIndex == 1) const SizedBox(height: 13),
          if (widget.selectedIndex == 1)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _titleController,
                  style: TextStyle(
                    color: _customColor.custom242424,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter title",
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
                    ref
                        .read(newDealDataProvider.notifier)
                        .updateNewDeal("title", value);
                  },
                ),
                const SizedBox(height: 13),
                Text(
                  "Category",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 5),
                CustomInputSelectionButton(
                    selectedItem: newDealData.categoryId != null
                        ? newDealData.category.toString()
                        : "Select Category",
                    hasSelected: newDealData.category != null,
                    onTap: _showCategoryBottomSheet),
                // CustomDropDown(
                //   hasSelected: newDealData.categoryId != null,
                //   dropdownItems: newDealData.dealDetailsCategory,
                //   selectItem: _selectCategory,
                //   selectedItem: newDealData.categoryId != null
                //       ? newDealData.category.toString()
                //       : "Select Category",
                //   errorMessage: _dealCategoryListErrorMessage,
                //   isLoading: _dealCategoryListIsLoading,
                //   retry: _fetchDealCategoryList,
                // ),
                const SizedBox(height: 13),
                Text(
                  "Sub category",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 5),

                CustomInputSelectionButton(
                  hasSelected: newDealData.subCategoryId != null,
                  onTap: _showSubCategoryBottomSheet,
                  selectedItem: newDealData.subCategoryId != null
                      ? newDealData.subCategory.toString()
                      : "Select sub category",
                ),
                // CustomDropDown(
                //   hasSelected: newDealData.subCategoryId != null,
                //   dropdownItems: newDealData.dealDetailsSubCategory,
                //   selectItem: _selectSubCategory,
                //   selectedItem: newDealData.subCategoryId != null
                //       ? newDealData.subCategory.toString()
                //       : "Select sub category",
                //   errorMessage: _dealSubCategoryListErrorMessage,
                //   isLoading: _dealSubCategoryListIsLoading,
                //   retry: _fetchDealSubCategoryList,
                // ),
                if (newDealData.type!.name == dealTypeDropdownItems[1].name ||
                    newDealData.type!.name ==
                        dealTypeDropdownItems[2].name) ...[
                  const SizedBox(height: 13),
                  AddImages(
                    uploadImage: _uploadImage,
                    firstImage: newDealData.dealDetailsImages![0],
                    secondImage: newDealData.dealDetailsImages![1],
                    thirdImage: newDealData.dealDetailsImages![2],
                  )
                ],
                if (newDealData.type!.name ==
                    dealTypeDropdownItems.last.name) ...[
                  const SizedBox(height: 13),
                  const SpaceLocationCard(),
                ],
                const SizedBox(height: 13),
                Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 120,
                  child: TextField(
                    controller: _descriptionController,
                    style: TextStyle(
                      color: _customColor.custom242424,
                      fontSize: 14,
                    ),
                    maxLines: null,
                    minLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter description",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(16),
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
                      ref
                          .read(newDealDataProvider.notifier)
                          .updateNewDeal("description", value);
                    },
                  ),
                ),

                if (showPrice) ...[
                  const SizedBox(height: 13),
                  Text(
                    "Price",
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
                        Container(
                          alignment: Alignment.center,
                          height: 48,
                          width: 44,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  width: 1, color: _customColor.customEFEFEF),
                            ),
                          ),
                          child: Text(
                            "₦",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: _customColor.custom6B7280),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(
                              color: _customColor.custom242424,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: "Enter price",
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
                              ref
                                  .read(newDealDataProvider.notifier)
                                  .updateNewDeal("price", value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 13),
                if (newDealData.type!.name ==
                    dealTypeDropdownItems[2].name) ...[
                  Text(
                    "Capacity",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _customColor.custom242424),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _capacityController,
                    style: TextStyle(
                      color: _customColor.custom242424,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter space capacity",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
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
                      ref
                          .read(newDealDataProvider.notifier)
                          .updateNewDeal("capacity", value);
                    },
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
                            controller: _dimensionController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(
                              color: _customColor.custom242424,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: "Enter dimensions (e.g., 20x30 cm)",
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
                              ref
                                  .read(newDealDataProvider.notifier)
                                  .updateNewDeal("dimension", value);
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 48,
                          width: 83,
                          child: Text(
                            "metres",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: _customColor.custom6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                // TextFormField(
                //   style: TextStyle(
                //     color: _customColor.custom242424,
                //     fontSize: 14,
                //   ),
                //   keyboardType: TextInputType.number,
                //   inputFormatters: [
                //     FilteringTextInputFormatter.digitsOnly,
                //   ],
                //   decoration: InputDecoration(
                //     hintText: "₦0",
                //     filled: true,
                //     fillColor: Colors.white,
                //     contentPadding: const EdgeInsets.all(16),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //       borderSide: BorderSide(
                //         color: _customColor.customEFEFEF,
                //         width: 1,
                //       ),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //       borderSide: BorderSide(
                //         color: _customColor.customEFEFEF,
                //         width: 1,
                //       ),
                //     ),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //       borderSide: BorderSide(
                //         color: _customColor.customEFEFEF,
                //         width: 1,
                //       ),
                //     ),
                //     errorBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //       borderSide: const BorderSide(width: 1),
                //     ),
                //     hintStyle: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.w400,
                //       color: _customColor.custom888888,
                //     ),
                //   ),
                //   onChanged: (value) async {},
                // ),
                if (showQuote) ...[
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Contact for quote",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _customColor.custom6D6D6D),
                      ),
                      SwitchButtonOutlined(
                          isOn: newDealData.contactForQuote,
                          toggleHandler: _toggleContactForQuote),
                    ],
                  )
                ],
                if (newDealData.type!.name ==
                    dealTypeDropdownItems[1].name) ...[
                  const SizedBox(height: 16),
                  Text(
                    "Duration",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424,
                    ),
                  ),
                  const SizedBox(height: 9),
                  CustomDropDown(
                    hasSelected: newDealData.duration != null,
                    dropdownItems: dealTypeDropdownItems,
                    selectItem: _selectDuration,
                    selectedItem: newDealData.duration != null
                        ? newDealData.duration.toString()
                        : "Select number of rooms",
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No of rooms for cleaning",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424,
                    ),
                  ),
                  const SizedBox(height: 9),
                  CustomDropDown(
                    hasSelected: newDealData.noOfRoomsForCleaning != null,
                    dropdownItems: dealTypeDropdownItems,
                    selectItem: _selectNoOfRoomsForCleaning,
                    selectedItem: newDealData.noOfRoomsForCleaning != null
                        ? newDealData.noOfRoomsForCleaning.toString()
                        : "Select number of rooms",
                  ),
                ],
                if (newDealData.varient.isNotEmpty &&
                    newDealData.type!.name ==
                        dealTypeDropdownItems[0].name) ...[
                  const SizedBox(height: 16),
                  Column(
                      children:
                          newDealData.varient.asMap().entries.map((entry) {
                    return VarientCard(
                      marginButtom:
                          entry.key == newDealData.varient.length + 1 ? 0 : 8,
                      toggleVarient: _resizeVarient,
                      hasExpanded: _selectedVarient == entry.key + 1,
                      color: entry.value.color,
                      dimension: entry.value.dimension,
                      images: entry.value.images,
                      material: entry.value.material,
                      size: entry.value.size,
                      weight: entry.value.weight,
                      index: entry.key + 1,
                      key: ValueKey(entry.key),
                    );
                  }).toList()),
                ],
                //if (newDealData.type == dealTypeDropdownItems[1].name)
                if (!newDealData.showAddAVarientBtn &&
                    newDealData.type!.name ==
                        dealTypeDropdownItems[0].name) ...[
                  const SizedBox(height: 13),
                  VarientCard(index: newDealData.varient.length + 1)
                ],
                if (newDealData.showAddAVarientBtn &&
                    newDealData.type!.name ==
                        dealTypeDropdownItems[0].name) ...[
                  const SizedBox(height: 13),
                  GestureDetector(
                      onTap: () {
                        print("clickddd");
                        // if (newDealData.varient.isEmpty) {
                        //   ref
                        //       .read(newDealDataProvider.notifier)
                        //       .updateNewDeal("contactForQuote", false);
                        // }
                        ref
                            .read(newDealDataProvider.notifier)
                            .updateNewDeal("showAddAVarientBtn", false);
                      },
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 1, color: _customColor.customEFEFEF)),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icon/add_circle_orange.png",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Add a variant",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: theme.primaryColor),
                            )
                          ],
                        ),
                      ))
                ],
              ],
            )
        ],
      ),
    );
  }
}
