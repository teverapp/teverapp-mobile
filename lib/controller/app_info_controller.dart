import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tever/model/country.dart';

class AppInfoControllerNotifier extends StateNotifier<Country> {
  AppInfoControllerNotifier() : super(Country.defaultState());

  Future<void> initializeSelectedCountry() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? countryJson = prefs.getString('selectedCountry');

      if (countryJson != null) {
        final Map<String, dynamic> countryMap = json.decode(countryJson);

        state = Country.fromJson(countryMap);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setCountry(Country info) async {
    try {
      state = info;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String countryJson = json.encode(info.toJson());
      await prefs.setString('selectedCountry', countryJson);
    } catch (error) {
      rethrow;
    }
  }
}

final appInfoProvider =
    StateNotifierProvider<AppInfoControllerNotifier, Country>((ref) {
  return AppInfoControllerNotifier();
});
