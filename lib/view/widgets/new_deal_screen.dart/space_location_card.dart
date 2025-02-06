import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_resource_controller.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/coordinate.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/general/common/custom_drop_down.dart';
import 'package:tever/view/widgets/general/common/custom_input_selection_button.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/countries_bottom_sheet.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/states_bottom_sheet.dart';
import 'package:tever/view/widgets/new_event_screen/address_list_bottom_sheet.dart';

class SpaceLocationCard extends ConsumerStatefulWidget {
  const SpaceLocationCard({super.key});

  @override
  ConsumerState<SpaceLocationCard> createState() => _SpaceLocationCardState();
}

class _SpaceLocationCardState extends ConsumerState<SpaceLocationCard> {
  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  String? _countryListErrorMessage;

  bool _countryListIsLoading = false;

  String? _stateListErrorMessage;

  bool _stateListIsLoading = false;

  void _showToast({required String message, required String status}) {
    if (mounted) {
      ToastService.showToast(
        context: context,
        message: message,
        status: status,
      );
    }
  }

  void _selectSpaceLocationAddress({required Coordinate location}) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("spaceLocationAddress", location);
  }

  void _showAddressBottomSheet({String? searchInput}) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return AddressListButtomSheet(
          title: "Enter address",
          intialSearchInput: searchInput,
          selectLocation: _selectSpaceLocationAddress,
        );
      },
    );
  }

  // bool _validateState() {
  //   final newDealData = ref.watch(newDealDataProvider);

  //   final appResourceData = ref.watch(appResourceProvider);

  //   final isValid = newDealData.selectedCountryFromAllCountryId != null;

  //   if (isValid && appResourceData.fetchedStates.isEmpty) {
  //     _fetchStateList(id: newDealData.selectedCountryFromAllCountryId);
  //   }

  //   if (!isValid) {
  //     _showToast(
  //         message: "Please select space location country!",
  //         status: ToastStatus.error.name);
  //   }

  //   return isValid;
  // }

  void _selectState(
      {required String value, required String id, String? imageUrl}) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("spaceLocationState", value);
  }

  void _selectCountry(
      {required String value, required String id, String? imageUrl}) {
    ref.read(newDealDataProvider.notifier).resetSpaceLocationSelectedState();

    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("spaceLocationCountry", value);
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("selectedCountryFromAllCountryId", id);

    print("checknn slee $id");
  }

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
          selectedItem: selectedItem,
          type: type,
          id: id,
          selectCountry: selectCountry,
        );
      },
    );
  }

  void _showStatesBottomSheet() {
    final newDealData = ref.watch(newDealDataProvider);

    final isValid = newDealData.selectedCountryFromAllCountryId != null;

    if (!isValid) {
      _showToast(
          message: "Please select space location country!",
          status: ToastStatus.error.name);

      return;
    }

    print("checknn ${newDealData.selectedCountryFromAllCountryId}");
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
          selectedItem: newDealData.spaceLocationState ?? "",
          hideBulletPoints: false,
          selectItem: _selectState,
          countryId: newDealData.selectedCountryFromAllCountryId.toString(),
        );
      },
    );
  }

  Future<void> _fetchStateList({required String? id}) async {
    print("sttaed calllled");
    setState(() {
      _stateListErrorMessage = null;
      _stateListIsLoading = true;
    });

    try {
      await ref
          .read(appResourceProvider.notifier)
          .fetchResources(type: DealsDropList.state.value, id: id);
    } on CustomHttpException catch (error) {
      setState(() {
        _stateListErrorMessage = error.toString();
      });
    } catch (error) {
      String errorMessage = error.toString();

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }

      setState(() {
        _stateListErrorMessage = errorMessage;
      });
    } finally {
      setState(() {
        _stateListIsLoading = false;
      });
    }
  }

  final CustomColors _customColor = const CustomColors();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newDealData = ref.watch(newDealDataProvider);

      _addressController.text =
          newDealData.spaceLocationAddress?.locationName ?? "";

      _cityController.text = newDealData.spaceLocationCity ?? "";
    });
  }

  @override
  void dispose() {
    super.dispose();
    _addressController.dispose();

    _cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newDealData = ref.watch(newDealDataProvider);

    final appResourceData = ref.watch(appResourceProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Space Location",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _customColor.custom4F4F4F),
          ),
          const SizedBox(height: 16),
          Text(
            "Country",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 5),
          // CustomDropDown(
          //   //
          //   // dropdownItems: _color,
          //   // selectItem: _selectCountry,

          //   dropDownHeight: 180,
          //   key: const Key("country"),
          //   validateBeforeShowingList: _validateCountry,
          //   hasSelected: newDealData.spaceLocationCountry != null,
          //   dropdownItems: appResourceData.fetchedCountries,
          //   selectItem: _selectCountry,
          //   selectedItem: newDealData.spaceLocationCountry != null
          //       ? newDealData.spaceLocationCountry.toString()
          //       : "Choose category",
          //   errorMessage: _countryListErrorMessage,
          //   isLoading: _countryListIsLoading,
          //   retry: () => _fetchCountryList(),
          // ),
          CustomInputSelectionButton(
              hasSelected: newDealData.spaceLocationCountry != null,
              onTap: () => _showCountryToBottomSheet(
                    selectedItem: newDealData.spaceLocationCountry.toString(),
                    type: DealsDropList.allCountries.value,
                    selectCountry: _selectCountry,
                  ),
              selectedItem: newDealData.spaceLocationCountry != null
                  ? newDealData.spaceLocationCountry.toString()
                  : "Choose country"),
          const SizedBox(height: 13),
          Text(
            "Address",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 5),
          CustomInputSelectionButton(
            hideTrailingIcon: true,
            selectedItem: newDealData.spaceLocationAddress != null
                ? newDealData.spaceLocationAddress!.locationName.toString()
                : "Enter your address",
            hasSelected: newDealData.spaceLocationAddress != null,
            onTap: () => _showAddressBottomSheet(
              searchInput: newDealData.spaceLocationAddress?.locationName,
            ),
          ),

          // TextField(
          //     controller: _addressController,
          //     style: TextStyle(
          //       color: _customColor.custom242424,
          //       fontSize: 14,
          //     ),
          //     decoration: InputDecoration(
          //       hintText: "Enter address",
          //       filled: true,
          //       fillColor: Colors.white,
          //       contentPadding:
          //           const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          //       focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(12),
          //         borderSide: BorderSide(
          //           color: _customColor.customEFEFEF,
          //           width: 1,
          //         ),
          //       ),
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(12),
          //         borderSide: BorderSide(
          //           color: _customColor.customEFEFEF,
          //           width: 1,
          //         ),
          //       ),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(12),
          //         borderSide: BorderSide(
          //           color: _customColor.customEFEFEF,
          //           width: 1,
          //         ),
          //       ),
          //       errorBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(12),
          //         borderSide: const BorderSide(width: 1),
          //       ),
          //       hintStyle: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w400,
          //         color: _customColor.custom888888,
          //       ),
          //     ),
          //     onChanged: (value) {
          //       ref
          //           .read(newDealDataProvider.notifier)
          //           .updateNewDeal("spaceLocationAddress", value);
          //     }),
          const SizedBox(height: 13),
          Text(
            "City",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _cityController,
            style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: "Enter city",
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
                  .updateNewDeal("spaceLocationCity", value);
            },
          ),
          const SizedBox(height: 16),
          Text(
            "State",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 5),
          CustomInputSelectionButton(
            selectedItem: newDealData.spaceLocationState != null
                ? newDealData.spaceLocationState.toString()
                : "Select state",
            hasSelected: newDealData.spaceLocationState != null,
            onTap: _showStatesBottomSheet,
          ),
          // CustomDropDown(
          //   dropDownHeight: 180,
          //   validateBeforeShowingList: _validateState,
          //   key: const Key("state"),
          //   hideBulletPoint: true,
          //   hasSelected: newDealData.spaceLocationState != null,
          //   dropdownItems: appResourceData.fetchedStates,
          //   selectItem: _selectState,
          //   selectedItem: newDealData.spaceLocationState != null
          //       ? newDealData.spaceLocationState.toString()
          //       : "Choose state",
          //   errorMessage: _stateListErrorMessage,
          //   isLoading: _stateListIsLoading,
          //   retry: () => _fetchStateList(
          //       id: newDealData.selectedCountryFromAllCountryId),
          // ),
        ],
      ),
    );
  }
}
