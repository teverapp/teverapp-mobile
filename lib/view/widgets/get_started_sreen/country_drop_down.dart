import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/helpers/world_countries.dart';
import 'package:tever/model/country.dart';

class CountryDropDown extends StatefulWidget {
  final bool showCountryDropDown;
  final Function onTap;
  const CountryDropDown({
    super.key,
    required this.showCountryDropDown,
    required this.onTap,
    // this.basicPicker = const CountryPicker(disabled: [CountryAbw()]),
  });

  //final CountryPicker basicPicker;

  @override
  State<CountryDropDown> createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
//  late CountryPicker picker = widget.basicPicker.copyWith(onSelect: onSelect);

  final TextEditingController _countryController = TextEditingController();

  // void onSelect(WorldCountry newCountry) {
  //   setState(() {
  //     picker = picker.copyWith(
  //       chosen: selectedCountry == newCountry ? const [] : [newCountry],
  //     );
  //   });
  // }

  //WorldCountry? get selectedCountry => picker.chosen?.firstOrNull;

  final CustomColors _customColor = const CustomColors();

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
        onTap: () => widget.onTap(Country(
          name: country,
          flag: flagEmoji,
          phoneCode: countryPhoneCode,
          countryCode: countryCode,
        )),
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

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      top: widget.showCountryDropDown ? 65 : 30,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: widget.showCountryDropDown ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Visibility(
          visible: widget.showCountryDropDown,
          child: Container(
            height: 182,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: _customColor.custom2424241F,
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(width: 1, color: _customColor.customEFEFEF)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Positioned(
                      right: 0,
                      left: 0,
                      top: 0,
                      bottom: 0,
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
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(children: [
                        SizedBox(
                          height: 35,
                          child: TextField(
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
                                margin: const EdgeInsets.only(
                                    top: 10, left: 16, right: 8),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
