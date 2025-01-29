import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessTokenControllerNotifier extends StateNotifier<String> {
  AccessTokenControllerNotifier() : super('');

  Future<void> initializeAccessToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      print("initiazlizedTokennnnnnnnnnnnn $token");
      if (token != null) {
        state = token;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setToken(String token) async {
    print("settttttt token   ${token}");
    try {
      state = token;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      state = '';
    } catch (error) {
      rethrow;
    }
  }
}

final accessTokenProvider =
    StateNotifierProvider<AccessTokenControllerNotifier, String>((ref) {
  return AccessTokenControllerNotifier();
});
