import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/general/common/add_image_card.dart';
import 'package:tever/view/widgets/general/common/custom_drop_down.dart';
import 'package:tever/view/widgets/general/common/custom_input_selection_button.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/add_affliate_marketing_card.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/add_button.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/add_promotion_material_card.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/promotion_type_buttom_sheet.dart';

class NewDealPromotion extends ConsumerStatefulWidget {
  final int selectedIndex;
  final VoidCallback newDealPromotionResize;
  const NewDealPromotion({
    super.key,
    required this.selectedIndex,
    required this.newDealPromotionResize,
  });

  @override
  ConsumerState<NewDealPromotion> createState() => _NewDealPromotionState();
}

class _NewDealPromotionState extends ConsumerState<NewDealPromotion> {
  final CustomColors _customColor = const CustomColors();

  final TextEditingController _promotionValueController =
      TextEditingController();

  final TextEditingController _promotionCodeController =
      TextEditingController();

  final TextEditingController _validityDateController = TextEditingController();

  void _hideShowAddPromotionMaterialCardHandler() {
    // setState(() {
    //   _showAddPromotionMaterialCard = false;
    // });

    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("showAddPromotionMaterialCard", false);

    ref.read(newDealDataProvider.notifier).updateNewDeal("dpmi", null);
  }

  void _hideShowAddAffliateMarketingCarddHandler() {
    // setState(() {
    //   _showAddAffliateMarketingCard = false;
    // });

    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("showAddAffliateMarketingCard", false);

    ref.read(newDealDataProvider.notifier).updateNewDeal("dpamev", null);
  }

  void _addPromotionMaterial() {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("showAddPromotionMaterialCard", true);

    // setState(() {
    //   _showAddPromotionMaterialCard = true;
    // });
  }

  void _addAffliateMarketing() {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("showAddAffliateMarketingCard", true);
    //   setState(() {
    //     _showAddAffliateMarketingCard = true;
    //   });
  }

  Future<void> _showDatePicker() async {
    final DateTime now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year + 10),
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('d MMMM, yyyy').format(pickedDate);

      _validityDateController.text = formattedDate;

      ref
          .read(newDealDataProvider.notifier)
          .updateNewDeal("dealPromotionValidDate", formattedDate);
    }
  }

  void _showPromotionTypesBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const PromotionTypeButtomSheet();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newDealData = ref.watch(newDealDataProvider);

      _promotionValueController.text = newDealData.dealPromotionValue ?? "";

      _promotionCodeController.text = newDealData.dealPromotionCode ?? "";

      _validityDateController.text = newDealData.dealPromotionValidDate ?? "";
    });
  }

  @override
  void dispose() {
    super.dispose();
    _promotionCodeController.dispose();

    _promotionValueController.dispose();

    _validityDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newDealData = ref.watch(newDealDataProvider);

    return Container(
      padding: EdgeInsets.only(
          bottom: widget.selectedIndex == 0 ? 16.0 : 10, left: 16, right: 16),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: _customColor.customEFEFEF))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.newDealPromotionResize,
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
                        widget.selectedIndex == 2
                            ? "assets/icon/minus_circle.png"
                            : "assets/icon/add_circle_dark.png",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Promotion",
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
          if (widget.selectedIndex == 2) ...[
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Promotion type",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 9),
                CustomInputSelectionButton(
                  hasSelected: newDealData.dealPromotionType != null,
                  onTap: _showPromotionTypesBottomSheet,
                  selectedItem: newDealData.dealPromotionType != null
                      ? newDealData.dealPromotionType.toString()
                      : "Select promotion type",
                ),
                // CustomDropDown(
                //   validateBeforeShowingList: _validatePromotionType,
                //   hasSelected: newDealData.dealPromotionType != null,
                //   dropdownItems: newDealData.fetchedPromotionType,
                //   selectItem: _selectPromotionType,
                //   selectedItem: newDealData.dealPromotionType != null
                //       ? newDealData.dealPromotionType.toString()
                //       : "Select promotion type",
                //   errorMessage: _countryListErrorMessage,
                //   isLoading: _countryListIsLoading,
                //   retry: _fetchPromotionType,
                // ),
                const SizedBox(height: 16),
                Text(
                  "Promotion value",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 9),
                TextField(
                  controller: _promotionValueController,
                  style: TextStyle(
                    color: _customColor.custom242424,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter value",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(left: 16, bottom: 1),
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
                        .updateNewDeal("dealPromotionValue", value);
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  "Promotion code",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 9),
                TextField(
                  controller: _promotionCodeController,
                  style: TextStyle(
                    color: _customColor.custom242424,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: "E.g. CLEAN30BG",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(left: 16, bottom: 1),
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
                        .updateNewDeal("dealPromotionCode", value);
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  "Valid till",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 9),
                TextField(
                  controller: _validityDateController,
                  readOnly: true,
                  style: TextStyle(
                    color: _customColor.custom242424,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: "Pick a date",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIconConstraints:
                        const BoxConstraints(maxHeight: 150, maxWidth: 150),
                    prefixIcon: Container(
                      margin: const EdgeInsets.only(left: 16, right: 8),
                      child: Image.asset(
                        "assets/icon/calendar.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(left: 16, bottom: 1),
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
                  onTap: _showDatePicker,
                ),
                const SizedBox(height: 16),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ref.read(newDealDataProvider.notifier).updateNewDeal(
                                "requiredCustomerToInputCodeDuringCheckOut",
                                !newDealData
                                    .requiredCustomerToInputCodeDuringCheckOut!);
                          },
                          child: Image.asset(
                            newDealData
                                    .requiredCustomerToInputCodeDuringCheckOut!
                                ? "assets/icon/radio_active_circular.png"
                                : "assets/icon/radio_inactive_circular.png",
                            height: 20,
                            width: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Require customer to input code during checkout",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: _customColor.custom242424),
                        )
                      ],
                    )),
                if (newDealData.showAddPromotionMaterialCard) ...[
                  const SizedBox(height: 24),
                  AddPromotionMaterialCard(
                    close: _hideShowAddPromotionMaterialCardHandler,
                  ),
                ],
                if (!newDealData.showAddPromotionMaterialCard) ...[
                  const SizedBox(height: 16),
                  AddButton(
                    label: "Add promotion material",
                    onTap: _addPromotionMaterial,
                  ),
                ],
                if (newDealData.showAddAffliateMarketingCard) ...[
                  const SizedBox(height: 24),
                  AddAffliateMarketingCard(
                    close: _hideShowAddAffliateMarketingCarddHandler,
                  ),
                ],
                if (!newDealData.showAddAffliateMarketingCard) ...[
                  const SizedBox(height: 16),
                  AddButton(
                    label: "Add affiliate marketing",
                    onTap: _addAffliateMarketing,
                  ),
                ]
              ],
            )
          ]
        ],
      ),
    );
  }
}
