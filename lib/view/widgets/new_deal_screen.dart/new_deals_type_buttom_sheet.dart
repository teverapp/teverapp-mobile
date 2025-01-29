import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class NewDealsTypeButtomSheet extends ConsumerStatefulWidget {
  const NewDealsTypeButtomSheet({super.key});

  @override
  ConsumerState<NewDealsTypeButtomSheet> createState() =>
      _NewDealsTypeButtomSheetState();
}

class _NewDealsTypeButtomSheetState
    extends ConsumerState<NewDealsTypeButtomSheet> {
  final CustomColors _customColor = const CustomColors();

  void _selectNewDealsType(
      {required String value, required String id, String? imageUrl}) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("type", CommonType(name: value, id: id));

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dealsData = ref.read(newDealDataProvider);

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 243,
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
              "Deal type",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Anybody",
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 14),
            NewDealBottomSheetList(
                hasSelected: true,
                dropdownItems: dealTypeDropdownItems,
                selectItem: _selectNewDealsType,
                selectedItem: dealsData.type!.name.toString())
          ],
        ),
      ),
    );
  }
}
