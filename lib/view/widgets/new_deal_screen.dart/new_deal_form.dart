import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/new_deal_section.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_details.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_promotion.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_shopping_info.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_type.dart';

class NewDealForm extends ConsumerStatefulWidget {
  final Function next;
  const NewDealForm({
    super.key,
    required this.next,
  });

  @override
  ConsumerState<NewDealForm> createState() => _NewDealFormState();
}

class _NewDealFormState extends ConsumerState<NewDealForm> {
  static const CustomColors _customColor = CustomColors();
  int _selectedIndex = 0;

  void _toggleSection(DealSection section) {
    setState(() {
      _selectedIndex = (_selectedIndex == section.index) ? -1 : section.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final newDealInfo = ref.watch(newDealDataProvider);

    final contactForQuote = !newDealInfo.contactForQuote &&
            newDealInfo.price!.isEmpty &&
            newDealInfo.varient.isEmpty &&
            !newDealInfo.showAddAVarientBtn
        ? false
        : !newDealInfo.contactForQuote &&
                newDealInfo.price!.isEmpty &&
                newDealInfo.varient.isEmpty &&
                newDealInfo.showAddAVarientBtn
            ? true
            : !newDealInfo.contactForQuote &&
                    newDealInfo.price!.isEmpty &&
                    newDealInfo.varient.isEmpty
                ? false
                : !newDealInfo.contactForQuote &&
                        newDealInfo.price!.isNotEmpty &&
                        newDealInfo.varient.isNotEmpty
                    ? true
                    : ((newDealInfo.contactForQuote &&
                            newDealInfo.varient.isNotEmpty) ||
                        newDealInfo.price!.isNotEmpty);

    final typeItemisValid = newDealInfo.title!.isNotEmpty &&
        newDealInfo.categoryId != null &&
        newDealInfo.subCategoryId != null &&
        newDealInfo.description!.isNotEmpty &&
        newDealInfo.dealPromotionType != null &&
        newDealInfo.dealPromotionValue!.isNotEmpty &&
        newDealInfo.dealPromotionCode!.isNotEmpty &&
        newDealInfo.dealPromotionValidDate != null &&
        newDealInfo.shippingFromCountry != null &&
        newDealInfo.shippingToRegion != null
        //  If newDealInfo.contactForQuote is true, the function will return true regardless of the value of newDealInfo.price. If newDealInfo.contactForQuote is false, the function will validate that newDealInfo.price is not null.
        &&
        contactForQuote &&
        // If newDealInfo.showShippingRateCard is true, all of the following must not be null:
        // newDealInfo.shippingRateCourierservice
        // newDealInfo.shippingRateEstimatedDeliveryTime
        // newDealInfo.shippingRate
        (newDealInfo.showShippingRateCard!
            ? newDealInfo.shippingRateCourierservice != null &&
                newDealInfo.shippingRateEstimatedDeliveryTime != null &&
                newDealInfo.shippingRate != null
            : true) &&
        (!newDealInfo.showAddPromotionMaterialCard ||
            newDealInfo.dealPromotionMaterialImage != null) &&
        (!newDealInfo.showAddAffliateMarketingCard ||
            newDealInfo.dealPromotionAffliateMarketingEarningValue != null) &&
        ((newDealInfo.selectedCountries != null &&
                newDealInfo.selectedCountries!.isNotEmpty) ||
            (newDealInfo.selectedStates != null &&
                newDealInfo.selectedStates!.isNotEmpty));

    final typeServicesIsValid = newDealInfo.title!.isNotEmpty &&
        newDealInfo.categoryId != null &&
        newDealInfo.subCategoryId != null &&
        newDealInfo.description!.isNotEmpty &&
        newDealInfo.dealDetailsImages!.any((value) => value != null) &&
        (newDealInfo.contactForQuote || newDealInfo.price!.isNotEmpty) &&
        newDealInfo.noOfRoomsForCleaning != null &&
        newDealInfo.duration != null &&
        newDealInfo.dealPromotionType != null &&
        newDealInfo.dealPromotionValue!.isNotEmpty &&
        newDealInfo.dealPromotionCode!.isNotEmpty &&
        newDealInfo.dealPromotionValidDate != null &&
        (!newDealInfo.showAddPromotionMaterialCard ||
            newDealInfo.dealPromotionMaterialImage != null) &&
        (!newDealInfo.showAddAffliateMarketingCard ||
            newDealInfo.dealPromotionAffliateMarketingEarningValue != null);

    final typeSpaceIsValid = newDealInfo.title!.isNotEmpty &&
        newDealInfo.categoryId != null &&
        newDealInfo.subCategoryId != null &&
        newDealInfo.description!.isNotEmpty &&
        newDealInfo.spaceLocationCountry != null &&
        newDealInfo.spaceLocationAddress!.isNotEmpty &&
        newDealInfo.spaceLocationCity!.isNotEmpty &&
        newDealInfo.spaceLocationState != null &&
        newDealInfo.dealDetailsImages!.any((value) => value != null) &&
        newDealInfo.price!.isNotEmpty &&
        newDealInfo.capacity!.isNotEmpty &&
        newDealInfo.dimension!.isNotEmpty &&
        newDealInfo.dealPromotionType != null &&
        newDealInfo.dealPromotionValue!.isNotEmpty &&
        newDealInfo.dealPromotionCode!.isNotEmpty &&
        newDealInfo.dealPromotionValidDate != null &&
        (!newDealInfo.showAddPromotionMaterialCard ||
            newDealInfo.dealPromotionMaterialImage != null) &&
        (!newDealInfo.showAddAffliateMarketingCard ||
            newDealInfo.dealPromotionAffliateMarketingEarningValue != null);

    final isValid = newDealInfo.type!.name == dealTypeDropdownItems[0].name
        ? typeItemisValid
        : newDealInfo.type!.name == dealTypeDropdownItems[1].name
            ? typeServicesIsValid
            : typeSpaceIsValid;

    print(
        "checked contactForQuote ${newDealInfo.contactForQuote}  price ${newDealInfo.price} &&   variant${newDealInfo.varient} && showAddAVarientBtn ${newDealInfo.showAddAVarientBtn}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NewDealType(
              selectedIndex: _selectedIndex,
              newDealTypeResize: () => _toggleSection(DealSection.type)),
          const SizedBox(height: 16),
          NewDealDetails(
              selectedIndex: _selectedIndex,
              newDealDetailsResize: () => _toggleSection(DealSection.details)),
          const SizedBox(height: 16),
          NewDealPromotion(
            selectedIndex: _selectedIndex,
            newDealPromotionResize: () => _toggleSection(DealSection.promotion),
          ),
          const SizedBox(height: 16),
          NewDealShoppingInfo(
              selectedIndex: _selectedIndex,
              newDealShippingInfoResize: () =>
                  _toggleSection(DealSection.shippingInfo)),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: theme.colorScheme.error,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      "Save as draft",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: TextButton(
                    onPressed: () => isValid ? widget.next(1) : null,
                    style: TextButton.styleFrom(
                      backgroundColor: isValid
                          ? theme.primaryColor
                          : _customColor.customD1D1D1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      "Post deal",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
