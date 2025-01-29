import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/general/common/custom_drop_down.dart';
import 'package:tever/view/widgets/general/common/custom_input_selection_button.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/earning_value_button_sheet.dart';

class AddAffliateMarketingCard extends ConsumerStatefulWidget {
  final VoidCallback close;
  const AddAffliateMarketingCard({
    super.key,
    required this.close,
  });

  @override
  ConsumerState<AddAffliateMarketingCard> createState() =>
      _AddAffliateMarketingCardState();
}

class _AddAffliateMarketingCardState
    extends ConsumerState<AddAffliateMarketingCard> {
  final CustomColors _customColor = const CustomColors();

  void _showEarningValueBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const EarningValueButtonSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final newDealData = ref.watch(newDealDataProvider);

    print("add promotion ${newDealData.dealPromotionMaterialImage}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Text(
          "Earning value",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _customColor.custom242424,
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        CustomInputSelectionButton(
          hasSelected:
              newDealData.dealPromotionAffliateMarketingEarningValue != null,
          onTap: _showEarningValueBottomSheet,
          selectedItem:
              newDealData.dealPromotionAffliateMarketingEarningValue != null
                  ? newDealData.dealPromotionAffliateMarketingEarningValue
                      .toString()
                  : "Select Earning value",
        )
        // CustomDropDown(
        //   hasSelected:
        //       newDealData.dealPromotionAffliateMarketingEarningValue != null,
        //   dropdownItems: _earningValues,
        //   selectItem: _selectEarningValue,
        //   selectedItem:
        //       newDealData.dealPromotionAffliateMarketingEarningValue != null
        //           ? newDealData.dealPromotionAffliateMarketingEarningValue
        //               .toString()
        //           : "Select Earning value",
        // ),
      ],
    );
  }
}
