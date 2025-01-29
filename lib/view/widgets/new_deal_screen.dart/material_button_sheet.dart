import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class MaterialButtonSheet extends ConsumerStatefulWidget {
  final void Function(
      {required String value,
      required String id,
      String? imageUrl}) selectMaterial;
  final String? selectedMaterial;

  const MaterialButtonSheet({
    super.key,
    required this.selectedMaterial,
    required this.selectMaterial,
  });

  @override
  ConsumerState<MaterialButtonSheet> createState() =>
      _MaterialButtonSheetState();
}

class _MaterialButtonSheetState extends ConsumerState<MaterialButtonSheet> {
  final CustomColors _customColor = const CustomColors();

  String? _selectedMaterial;

  void _selectMaterial(
      {required String value, required String id, String? imageUrl}) {
    setState(() {
      _selectedMaterial = value;
    });

    widget.selectMaterial(value: value, id: id, imageUrl: imageUrl);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  void _addMoreItemsToMaterialList(CommonType value) {
    ref.read(newDealDataProvider.notifier).updateMaterials(material: value);
  }

  @override
  void initState() {
    super.initState();
    _selectedMaterial = widget.selectedMaterial;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final bottomSheetHeight = mediaQuery.height * 0.85;

    final newDealData = ref.watch(newDealDataProvider);

    return Container(
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
            hasSelected: _selectedMaterial != null,
            dropdownItems: newDealData.materials,
            selectItem: _selectMaterial,
            selectedItem: _selectedMaterial != null
                ? _selectedMaterial.toString()
                : "Select colour",
          )
        ],
      ),
    );
  }
}
