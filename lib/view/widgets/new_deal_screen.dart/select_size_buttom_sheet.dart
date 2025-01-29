import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class SelectSizeButtomSheet extends ConsumerStatefulWidget {
  final void Function(
      {required String value, required String id, String? imageUrl}) selectSize;
  final String? selectedSize;

  const SelectSizeButtomSheet({
    super.key,
    required this.selectedSize,
    required this.selectSize,
  });

  @override
  ConsumerState<SelectSizeButtomSheet> createState() =>
      _SelectSizeButtomSheetState();
}

class _SelectSizeButtomSheetState extends ConsumerState<SelectSizeButtomSheet> {
  final CustomColors _customColor = const CustomColors();

  String? _selectedSize;

  void _selectSize(
      {required String value, required String id, String? imageUrl}) {
    setState(() {
      _selectedSize = value;
    });

    widget.selectSize(value: value, id: id, imageUrl: imageUrl);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  void _addMoreItemsToMaterialList(CommonType value) {
    ref.read(newDealDataProvider.notifier).updateSizes(size: value);
  }

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.selectedSize;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final bottomSheetHeight = mediaQuery.height * 0.85;

    final newDealData = ref.watch(newDealDataProvider);

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: bottomSheetHeight,
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
              "Choose color",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Anybody",
                  color: _customColor.custom525252),
            ),
            NewDealBottomSheetList(
              showSearchField: true,
              addMoreItemsToList: _addMoreItemsToMaterialList,
              hasSelected: _selectedSize != null,
              dropdownItems: newDealData.sizes,
              selectItem: _selectSize,
              selectedItem: _selectedSize != null
                  ? _selectedSize.toString()
                  : "Select colour",
            )
          ],
        ),
      ),
    );
  }
}
