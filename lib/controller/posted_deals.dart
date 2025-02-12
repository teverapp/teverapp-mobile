import "dart:convert";

import "package:http/http.dart" as http;
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:tever/controller/access_token_controller.dart";
import "package:tever/helpers/general.dart";
import "package:tever/model/custom_http_exception.dart";
import "package:tever/model/new_deal.dart";
import "package:tever/model/posted_deals.dart";

class PostedDealsControllerNotifier extends StateNotifier<List<PostedDeals>> {
  PostedDealsControllerNotifier({required this.ref}) : super([]);
  final Ref ref;

  Future<void> fetchPostedDeals() async {
    final token = ref.watch(accessTokenProvider);
    final url = Uri.parse("$baseUrl/deals/me/fetch");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      final responseData =
          response.body.isNotEmpty ? jsonDecode(response.body) : {};

      print("fetch posted deals responseData ==> $responseData");

      if (response.statusCode == 200) {
        print("Fetched posted deals successfully!");

        final List<dynamic> dealsList = responseData['data'] ?? [];

        final List<PostedDeals> postedDeals = dealsList
            .map((dealJson) => PostedDeals.fromJson(dealJson))
            .toList();

        state = postedDeals;

        return;
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        await ref.read(accessTokenProvider.notifier).deleteToken();
        throw CustomHttpException("401");
      }

      final errorMessage = responseData['error']?['message'] ??
          responseData['message'] ??
          "Unknown error occurred";
      throw CustomHttpException(errorMessage);
    } catch (error) {
      print("fetch posted deals error: ${error.toString()}");
      rethrow;
    }
  }
}

final postedDealsProvider =
    StateNotifierProvider<PostedDealsControllerNotifier, List<PostedDeals>>(
        (ref) {
  return PostedDealsControllerNotifier(ref: ref);
});
