import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/general/common/custom_drop_down.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

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

  bool _validateCountry() {
    final newDealData = ref.watch(newDealDataProvider);

    if (newDealData.countries.isEmpty) {
      _fetchCountryList(fetchItemWithId: false);
    }

    return true;
  }

  bool _validateState() {
    final newDealData = ref.watch(newDealDataProvider);

    final isValid = newDealData.selectedCountryFromAllCountryId != null;

    if (isValid && newDealData.fetchedStates.isEmpty) {
      _fetchStateList(fetchItemWithId: true);
    }

    if (!isValid) {
      _showToast(
          message: "Please select space location country!",
          status: ToastStatus.error.name);
    }

    return isValid;
  }

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
  }

  Future<void> _fetchCountryList({required bool fetchItemWithId}) async {
    setState(() {
      _countryListIsLoading = true;
      _countryListErrorMessage = null;
    });

    try {
      await ref.read(newDealDataProvider.notifier).fetchResources(
          type: DealsDropList.country.value, fetchItemWithId: false);
    } on CustomHttpException catch (error) {
      setState(() {
        _countryListErrorMessage = error.toString();
      });
    } catch (error) {
      String errorMessage = error.toString();

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }

      print("errorrrrrrr $errorMessage");
      setState(() {
        _countryListErrorMessage = errorMessage;
      });
    } finally {
      setState(() {
        _countryListIsLoading = false;
      });
    }
  }

  Future<void> _fetchStateList({required bool fetchItemWithId}) async {
    print("sttaed calllled");
    setState(() {
      _stateListErrorMessage = null;
      _stateListIsLoading = true;
    });

    try {
      await ref.read(newDealDataProvider.notifier).fetchResources(
          type: DealsDropList.state.value, fetchItemWithId: fetchItemWithId);
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

      _addressController.text = newDealData.spaceLocationAddress ?? "";

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
          CustomDropDown(
            //
            // dropdownItems: _color,
            // selectItem: _selectCountry,

            dropDownHeight: 180,
            key: const Key("country"),
            validateBeforeShowingList: _validateCountry,
            hasSelected: newDealData.spaceLocationCountry != null,
            dropdownItems: newDealData.countries,
            selectItem: _selectCountry,
            selectedItem: newDealData.spaceLocationCountry != null
                ? newDealData.spaceLocationCountry.toString()
                : "Choose category",
            errorMessage: _countryListErrorMessage,
            isLoading: _countryListIsLoading,
            retry: () => _fetchCountryList(fetchItemWithId: false),
          ),
          const SizedBox(height: 13),
          Text(
            "Address",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 5),
          TextField(
              controller: _addressController,
              style: TextStyle(
                color: _customColor.custom242424,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: "Enter address",
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
                    .updateNewDeal("spaceLocationAddress", value);
              }),
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
          CustomDropDown(
            dropDownHeight: 180,
            validateBeforeShowingList: _validateState,
            key: const Key("state"),
            hideBulletPoint: true,
            hasSelected: newDealData.spaceLocationState != null,
            dropdownItems: newDealData.fetchedStates,
            selectItem: _selectState,
            selectedItem: newDealData.spaceLocationState != null
                ? newDealData.spaceLocationState.toString()
                : "Choose state",
            errorMessage: _stateListErrorMessage,
            isLoading: _stateListIsLoading,
            retry: () => _fetchStateList(fetchItemWithId: true),
          ),
        ],
      ),
    );
  }
}
