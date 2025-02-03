import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/helpers/world_countries.dart';
import 'package:tever/model/country.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/screens/tabs_screen.dart';
import 'package:tever/view/screens/waiting_screen.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';
import 'package:tever/view/widgets/otp_screen/otp_inputs.dart';
import 'package:tever/view/widgets/otp_screen/resend_otp.dart';

class CountryBottomSheet extends ConsumerStatefulWidget {
  final Function onTap;
  const CountryBottomSheet({super.key, required this.onTap});

  @override
  ConsumerState<CountryBottomSheet> createState() => _CountryBottomSheetState();
}

class _CountryBottomSheetState extends ConsumerState<CountryBottomSheet> {
  final CustomColors _customColor = const CustomColors();

  bool _useMediaHeight = false;

  final TextEditingController _countryController = TextEditingController();

  void _resizeBottomSheet() {
    setState(() {
      _useMediaHeight = true;
    });
  }

  // void onSelect(WorldCountry newCountry) {
  //   setState(() {
  //     picker = picker.copyWith(
  //       chosen: selectedCountry == newCountry ? const [] : [newCountry],
  //     );
  //   });
  // }

  //WorldCountry? get selectedCountry => picker.chosen?.firstOrNull;

  String _searchQuery = "";

  Widget _buildCountryCard({
    required String country,
    required String flagEmoji,
    required String countryPhoneCode,
    required String countryCode,
    required String searchQuery,
  }) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          widget.onTap(Country(
            name: country,
            flag: flagEmoji,
            phoneCode: countryPhoneCode,
            countryCode: countryCode,
          ));
          if (ModalRoute.of(context)?.isCurrent == true) {
            Navigator.of(context).pop();
          }
        },
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: OverflowBox(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      flagEmoji,
                      style: const TextStyle(fontSize: 27),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: RichText(
                text: _buildHighlightedText(country, searchQuery),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "($countryPhoneCode)",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _customColor.custom888888,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextSpan _buildHighlightedText(String text, String query) {
    if (query.isEmpty) {
      return TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _customColor.custom888888,
        ),
      );
    }

    final matchIndex = text.toLowerCase().indexOf(query.toLowerCase());
    if (matchIndex == -1) {
      return TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _customColor.custom242424,
        ),
      );
    }

    final beforeMatch = text.substring(0, matchIndex);
    final matchText = text.substring(matchIndex, matchIndex + query.length);
    final afterMatch = text.substring(matchIndex + query.length);

    return TextSpan(
      children: [
        TextSpan(
          text: beforeMatch,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _customColor.custom888888,
          ),
        ),
        TextSpan(
          text: matchText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _customColor.custom242424,
          ),
        ),
        TextSpan(
          text: afterMatch,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _customColor.custom888888,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _countryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCountries = worldCountries.where((country) {
      return country.name.toLowerCase().startsWith(_searchQuery.toLowerCase());
    }).toList();

    final mediaQuery = MediaQuery.of(context).size;

    final double height = _useMediaHeight ? mediaQuery.height * 0.9 : 270;

    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
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
            const SizedBox(height: 25),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(children: [
                SizedBox(
                  height: 36,
                  child: TextField(
                    onTap: _resizeBottomSheet,
                    controller: _countryController,
                    autocorrect: true,
                    enableSuggestions: true,
                    style: TextStyle(
                      color: _customColor.custom242424,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIconConstraints: const BoxConstraints(
                        maxHeight: 50,
                        maxWidth: 150,
                      ),
                      prefixIcon: Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 16, right: 8),
                        child: Image.asset(
                          "assets/icon/search_dark.png",
                          height: 14,
                          width: 14,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom888888,
                      ),
                    ),
                    onChanged: (value) {
                      _countryController.text = value;
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                Divider(thickness: 1, color: _customColor.customEFEFEF),
              ]),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                final flagEmoji = country.flag;

                return _buildCountryCard(
                    country: country.name,
                    flagEmoji: flagEmoji,
                    countryCode: country.countryCode,
                    countryPhoneCode: country.phoneCode,
                    searchQuery: _searchQuery);
              },
            )),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
