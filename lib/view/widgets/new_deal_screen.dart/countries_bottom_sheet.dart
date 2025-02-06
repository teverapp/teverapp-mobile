import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_resource_controller.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class CountriesButtomSheet extends ConsumerStatefulWidget {
  final String type;
  final bool refetchCountry;
  final String selectedItem;
  final void Function(
      {required String value,
      required String id,
      String? imageUrl}) selectCountry;
  final String? id;

  const CountriesButtomSheet(
      {super.key,
      required this.selectCountry,
      required this.id,
      required this.type,
      required this.selectedItem,
      this.refetchCountry = false});

  @override
  ConsumerState<CountriesButtomSheet> createState() =>
      _CountriesButtomSheetState();
}

class _CountriesButtomSheetState extends ConsumerState<CountriesButtomSheet> {
  final CustomColors _customColor = const CustomColors();

  String? _countryListErrorMessage;

  bool _countryListIsLoading = false;

  void _selectCountry(
      {required String value, required String id, String? imageUrl}) {
    widget.selectCountry(value: value, id: id, imageUrl: imageUrl);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _fetchCountryList({required dynamic id}) async {
    setState(() {
      _countryListIsLoading = true;
      _countryListErrorMessage = null;
    });

    try {
      await ref
          .read(appResourceProvider.notifier)
          .fetchResources(type: DealsDropList.country.value, id: id);
    } on CustomHttpException catch (error) {
      setState(() {
        _countryListErrorMessage = error.toString();
      });
    } catch (error) {
      String errorMessage = error.toString();

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }

      setState(() {
        _countryListErrorMessage = errorMessage;
      });
    } finally {
      setState(() {
        _countryListIsLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCountryList(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final newDealData = ref.read(newDealDataProvider);

    final appResourceData = ref.read(appResourceProvider);

    final mediaQuery = MediaQuery.of(context).size;

    final bottomSheetHeight = mediaQuery.height * 0.8;

    // String selectedItem = widget.type == DealsDropList.shippingFrom.name &&
    //         newDealData.shippingFromCountry != null
    //     ? newDealData.shippingFromCountry.toString()
    //     : widget.type == DealsDropList.shippingTo.name &&
    //             newDealData.shippingToCountry != null
    //         ? newDealData.shippingToCountry.toString()
    //         : "Select country";

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
            "Select Country",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Anybody",
                color: _customColor.custom525252),
          ),
          NewDealBottomSheetList(
              hideBulletPoint:
                  widget.type == DealsDropList.multipleSelection.name,
              showSearchField: true,
              hasSelected: widget.type == DealsDropList.shippingFrom.name
                  ? newDealData.shippingFromCountry != null
                  : newDealData.shippingToCountry != null,
              dropdownItems: appResourceData.fetchedCountries,
              selectItem: _selectCountry,
              selectedItem: widget.selectedItem,
              errorMessage: _countryListErrorMessage,
              isLoading: _countryListIsLoading,
              retry: () => _fetchCountryList(id: widget.id))
        ],
      ),
    );
  }
}
