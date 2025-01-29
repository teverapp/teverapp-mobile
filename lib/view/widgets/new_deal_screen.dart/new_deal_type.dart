import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/custom_input_selection_button.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deals_type_buttom_sheet.dart';

class NewDealType extends ConsumerStatefulWidget {
  final int selectedIndex;
  final VoidCallback newDealTypeResize;

  const NewDealType({
    super.key,
    required this.selectedIndex,
    required this.newDealTypeResize,
  });

  @override
  ConsumerState<NewDealType> createState() => _NewDealTypeState();
}

class _NewDealTypeState extends ConsumerState<NewDealType> {
  final CustomColors _customColor = const CustomColors();

  // void _selectNewDealsType(
  //     {required String value, required String id, String? imageUrl}) {
  //   ref.read(newDealDataProvider.notifier).updateNewDeal("type", value);
  // }

  void _showBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const NewDealsTypeButtomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dealsData = ref.watch(newDealDataProvider);

    return Container(
      padding: EdgeInsets.only(
        bottom: widget.selectedIndex == 0 ? 16.0 : 10,
        left: 16,
        right: 16,
      ),
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
          GestureDetector(
            onTap: widget.newDealTypeResize,
            child: Container(
              height: 38,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        widget.selectedIndex == 0
                            ? "assets/icon/minus_circle.png"
                            : "assets/icon/add_circle_dark.png",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Type",
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
          if (widget.selectedIndex == 0) const SizedBox(height: 16),
          if (widget.selectedIndex == 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "I want to promote...",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom242424,
                  ),
                ),
                const SizedBox(height: 9),
                CustomInputSelectionButton(
                    selectedItem: dealsData.type!.name.toString(),
                    hasSelected: dealsData.type?.name != null,
                    onTap: _showBottomSheet)
                // CustomDropDown(
                //     hasSelected: true,
                //     dropdownItems: dealTypeDropdownItems,
                //     selectItem: _selectNewDealsType,
                //     selectedItem: dealsData.type.toString()),
              ],
            )
        ],
      ),
    );
  }
}
