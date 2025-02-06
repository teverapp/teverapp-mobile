import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_resource_controller.dart';

import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/general/common/custom_input_selection_button.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/add_button.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/add_shiping_rate_card.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/continent_bottom_sheet.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/hide_new_deal_shipping_info.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/location_selection_list.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/regions_buttom_sheet.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/countries_bottom_sheet.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/states_bottom_sheet.dart';

class NewDealShoppingInfo extends ConsumerStatefulWidget {
  final int selectedIndex;
  final VoidCallback newDealShippingInfoResize;
  const NewDealShoppingInfo(
      {super.key,
      required this.selectedIndex,
      required this.newDealShippingInfoResize});

  @override
  ConsumerState<NewDealShoppingInfo> createState() =>
      _NewDealShoppingInfoState();
}

class _NewDealShoppingInfoState extends ConsumerState<NewDealShoppingInfo> {
  final CustomColors _customColor = const CustomColors();

  void _selectShipToCountry(
      {required String value, required String id, String? imageUrl}) {
    ref.read(newDealDataProvider.notifier).resetSelectedStateDetails();

    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("shippingToCountry", value);
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("shippingToCountryId", id);
  }

  void _addToSelectedCountries(
      {required String value, required String id, String? imageUrl}) {
    ref.read(newDealDataProvider.notifier).addToSelectedCountry(
            country: LocationSelection(
          name: value,
          flag: imageUrl,
          id: id,
        ));
  }

  void _removeSelectedCountry(int index) {
    print("clicked _removeSelectedCountry $index");
    ref
        .read(newDealDataProvider.notifier)
        .removeFromSelectedCountry(index: index);
  }

  void _removeSelectedState(int index) {
    print("clicked _removeSelectedState $index");
    ref
        .read(newDealDataProvider.notifier)
        .removeFromSelectedState(index: index);
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

  void _showShippingRateCard() {
    final newDealData = ref.watch(newDealDataProvider);

    ref.read(newDealDataProvider.notifier).updateNewDeal(
        "showShippingRateCard", !newDealData.showShippingRateCard!);
  }

  void _selectShipFromCountry(
      {required String value, required String id, String? imageUrl}) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("shippingFromCountry", value);
  }

  //type: DealsDropList.shippingFrom.name,

  void _showCountryToBottomSheet(
      {required String selectedItem,
      required String type,
      required Function(
              {required String value, required String id, String? imageUrl})
          selectCountry,
      String? id}) {
    print("_showCountryToBottomSheet $id");

    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return CountriesButtomSheet(
          type: type,
          id: id,
          refetchCountry: true,
          selectCountry: selectCountry,
          selectedItem: selectedItem,
        );
      },
    );
  }

  void _showCountryToUsingContinentIdBottomSheet(
      {required String selectedItem,
      required String type,
      required Function(
              {required String value, required String id, String? imageUrl})
          selectCountry,
      String? id}) {
    final newDealData = ref.watch(newDealDataProvider);

    final isValid = newDealData.shippingToContinentId != null;

    if (!isValid) {
      _showToast(
          message: "Please select a continent!",
          status: ToastStatus.error.name);

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
        return CountriesButtomSheet(
          type: type,
          id: id,
          selectCountry: selectCountry,
          selectedItem: selectedItem,
        );
      },
    );
  }

  void _showRegionBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const RegionsButtomSheet();
      },
    );
  }

  void _showContinentBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const ContinentBottomSheet();
      },
    );
  }

  void _addToSelectedStates(
      {required String value, required String id, String? imageUrl}) {
    ref.read(newDealDataProvider.notifier).addSelectedStates(
            selectedState: LocationSelection(
          name: value,
          id: id,
        ));
  }

  void _showStatesBottomSheet() {
    final newDealData = ref.watch(newDealDataProvider);

    final isValid = newDealData.shippingToCountryId != null;

    if (!isValid) {
      _showToast(
          message: "Please select a country!", status: ToastStatus.error.name);

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
        return StatesBottomSheet(
          selectedItem: "",
          selectItem: _addToSelectedStates,
          countryId: newDealData.shippingToCountryId!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final newDealData = ref.watch(newDealDataProvider);

    final bool showContinentInput =
        newDealData.shippingToRegion == regions[1].name;

    final isSectionActive =
        newDealData.type!.name == dealTypeDropdownItems[0].name;

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
            onTap: widget.newDealShippingInfoResize,
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
                        widget.selectedIndex == 3
                            ? "assets/icon/minus_circle.png"
                            : "assets/icon/add_circle_dark.png",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Shipping info",
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
          if (widget.selectedIndex == 3 && !isSectionActive) ...[
            const SizedBox(height: 8),
            const HideNewDealShippingInfo(),
          ],
          if (widget.selectedIndex == 3 && isSectionActive) ...[
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shipping from",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 9),
                CustomInputSelectionButton(
                  hasSelected: newDealData.shippingFromCountry != null,
                  onTap: () => _showCountryToBottomSheet(
                      selectedItem: newDealData.shippingFromCountry.toString(),
                      type: DealsDropList.shippingFrom.name,
                      //  id: newDealData.shippingToContinentId,
                      selectCountry: _selectShipFromCountry),
                  selectedItem: newDealData.shippingFromCountry != null
                      ? newDealData.shippingFromCountry.toString()
                      : "Select country",
                ),
                // CustomDropDown(
                //   validateBeforeShowingList: () => _validateCountry(false),
                //   dropDownHeight: 175,
                //   hasSelected: newDealData.shippingFromCountry != null,
                //   dropdownItems: newDealData.countries,
                //   selectItem: _selectShipFromCountry,
                //   selectedItem: newDealData.shippingFromCountry != null
                //       ? newDealData.shippingFromCountry.toString()
                //       : "Select country",
                //   errorMessage: _countryListErrorMessage,
                //   isLoading: _countryListIsLoading,
                //   retry: () => _fetchCountryList(fetchItemWithId: false),
                // ),
                const SizedBox(height: 24),
                Text(
                  "Shipping to",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 8),
                // CustomDropDown(
                //   dropDownHeight: 64,
                //   key: const Key("region"),
                //   hasSelected: newDealData.shippingToRegion != null,
                //   dropdownItems: _region,
                //   selectItem: _selectRegion,
                //   selectedItem: newDealData.shippingToRegion != null
                //       ? newDealData.shippingToRegion.toString()
                //       : "Select region",
                // ),
                CustomInputSelectionButton(
                  key: const Key("region"),
                  hasSelected: newDealData.shippingToRegion != null,
                  onTap: _showRegionBottomSheet,
                  selectedItem: newDealData.shippingToRegion != null
                      ? newDealData.shippingToRegion.toString()
                      : "Select region",
                ),
                if (newDealData.shippingToRegion != null) ...[
                  if (showContinentInput) ...[
                    const SizedBox(height: 8),
                    CustomInputSelectionButton(
                      key: const Key("continent"),
                      hasSelected: newDealData.shippingToContinent != null,
                      onTap: _showContinentBottomSheet,
                      selectedItem: newDealData.shippingToContinent != null
                          ? newDealData.shippingToContinent.toString()
                          : "Select continent",
                    ),
                    // CustomDropDown(
                    //   dropDownHeight: 146,
                    //   key: const Key("continent"),
                    //   hasSelected: newDealData.shippingToContinent != null,
                    //   dropdownItems: listOfContinents,
                    //   selectItem: _selectShippingToContinent,
                    //   selectedItem: newDealData.shippingToContinent != null
                    //       ? newDealData.shippingToContinent.toString()
                    //       : "Select continent",
                    // ),
                  ],
                  const SizedBox(height: 8),
                  CustomInputSelectionButton(
                    key: const Key("country"),
                    onTap: () => !showContinentInput
                        ? _showCountryToBottomSheet(
                            selectedItem: showContinentInput
                                ? ""
                                : newDealData.shippingToCountry.toString(),
                            type: showContinentInput
                                ? DealsDropList.multipleSelection.name
                                : DealsDropList.shippingTo.name,
                            id: newDealData.shippingToContinentId,
                            selectCountry: showContinentInput
                                ? _addToSelectedCountries
                                : _selectShipToCountry,
                          )
                        : _showCountryToUsingContinentIdBottomSheet(
                            selectedItem: showContinentInput
                                ? ""
                                : newDealData.shippingToCountry.toString(),
                            type: showContinentInput
                                ? DealsDropList.multipleSelection.name
                                : DealsDropList.shippingTo.name,
                            id: newDealData.shippingToContinentId,
                            selectCountry: showContinentInput
                                ? _addToSelectedCountries
                                : _selectShipToCountry,
                          ),
                    hasSelected: showContinentInput
                        ? false
                        : newDealData.shippingToCountry != null,
                    selectedItem: showContinentInput
                        ? "Country"
                        : newDealData.shippingToCountry != null
                            ? newDealData.shippingToCountry.toString()
                            : "Select country",
                  ),
                  // CustomDropDown(
                  //   dropDownHeight: 180,
                  //   key: const Key("country"),
                  //   validateBeforeShowingList: () =>
                  //       _validateCountry(showContinentInput),
                  //   hideBulletPoint: showContinentInput == true ? false : true,
                  //   hasSelected: showContinentInput
                  //       ? false
                  //       : newDealData.shippingToCountry != null,
                  //   dropdownItems: newDealData.countries,
                  //   selectItem: showContinentInput
                  //       ? _addToSelectedCountries
                  //       : _selectShipToCountry,
                  //   selectedItem: showContinentInput
                  //       ? "Country"
                  //       : newDealData.shippingToCountry != null
                  //           ? newDealData.shippingToCountry.toString()
                  //           : "Select country",
                  //   errorMessage: _countryListErrorMessage,
                  //   isLoading: _countryListIsLoading,
                  //   retry: () => _fetchCountryList(fetchItemWithId: true),
                  // ),
                  if (!showContinentInput) ...[
                    const SizedBox(height: 8),

                    CustomInputSelectionButton(
                      key: const Key("state"),
                      hasSelected: false,
                      onTap: _showStatesBottomSheet,
                      selectedItem: "State",
                    ),
                    // CustomDropDown(
                    //   dropDownHeight: 180,
                    //   validateBeforeShowingList: _validateState,
                    //   key: const Key("state"),
                    //   hideBulletPoint: false,
                    //   hasSelected: false,
                    //   dropdownItems: newDealData.fetchedStates,
                    //   selectItem: _addToSelectedStates,
                    //   selectedItem: "State",
                    //   errorMessage: _stateListErrorMessage,
                    //   isLoading: _stateListIsLoading,
                    //   retry: () => _fetchStateList(fetchItemWithId: true),
                    // ),
                    // CustomDropDown(
                    //   hasSelected: false,
                    //   hideBulletPoint: false,
                    //   dropdownItems: newDealData.countries,
                    //   selectItem: _addToSelectedStates,
                    //   selectedItem: "City",
                    //   errorMessage: _countryListErrorMessage,
                    //   isLoading: _countryListIsLoading,
                    //   retry: () => _fetchCountryList(fetchItemWithId: true),
                    // ),
                  ]
                ],
                if (newDealData.selectedCountries!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  LocationSelectionList(
                    remove: _removeSelectedCountry,
                    flagIsAvailabe: true,
                    label: newDealData.shippingToContinent.toString(),
                    listItem: newDealData.selectedCountries!.toList(),
                  ),
                ],
                if (newDealData.selectedStates!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  LocationSelectionList(
                    remove: _removeSelectedState,
                    label: newDealData.shippingToCountry.toString(),
                    listItem: newDealData.selectedStates!.toList(),
                  ),
                ],
                if (!newDealData.showShippingRateCard!) ...[
                  const SizedBox(height: 16),
                  AddButton(
                    label: "Add shipping rate",
                    onTap: _showShippingRateCard,
                  ),
                ],
                if (newDealData.showShippingRateCard!) ...[
                  const SizedBox(height: 16),
                  const AddShipingRateCard()
                ]
              ],
            )
          ]
        ],
      ),
    );
  }
}
