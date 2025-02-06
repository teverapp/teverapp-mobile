import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/business_profile.dart';

import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/model/business_profile.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class BusinessTypeBottomSheet extends ConsumerStatefulWidget {
  final String? selectedIetm;
  final String title;
  final double height;
  final List<CommonType> dropdownItems;
  final void Function(
      {required String value, required String id, String? imageUrl}) selectItem;
  const BusinessTypeBottomSheet({
    super.key,
    required this.selectItem,
    this.selectedIetm,
    required this.dropdownItems,
    required this.height,
    required this.title,
  });

  @override
  ConsumerState<BusinessTypeBottomSheet> createState() =>
      _BusinessTypeBottomSheetState();
}

class _BusinessTypeBottomSheetState
    extends ConsumerState<BusinessTypeBottomSheet> {
  final CustomColors _customColor = const CustomColors();

  void _selectBusinessOption(
      {required String value, required String id, String? imageUrl}) {
    widget.selectItem(value: value, id: id, imageUrl: imageUrl);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final creatingBusinessProfile = ref.watch(businessProfileProvider);

    print("businessType ${creatingBusinessProfile.businessType}");
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: widget.height,
        padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Anybody",
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 14),
            NewDealBottomSheetList(
                hasSelected: true,
                dropdownItems: widget.dropdownItems,
                selectItem: _selectBusinessOption,
                selectedItem: widget.selectedIetm ?? "")
          ],
        ),
      ),
    );
  }
}
