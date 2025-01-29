import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> uploadDeal({
  required String action,
  required int dealTypeId,
  required String title,
  required int categoryId,
  required int subCategoryId,
  required String description,
  required File coverImage,
  required bool isDraft,
  required double dealLong,
  required double dealLat,
  required int shippingId,
  required String userId,
  required bool isFeatured,
  required bool isPremium,
  required bool isTeverPick,
  required bool hasPromotion,
  required double price,
  required bool isBarter,
  required String currencyName,
  required int currencyId,
  required int pricingType,
  required String priceIndicator,
  // Add other fields as needed
}) async {
  final url = Uri.parse(
      'https://example.com/api/deal'); // Replace with your backend URL

  // Prepare multipart request
  final request = http.MultipartRequest('POST', url);

  // Add fields
  request.fields['Action'] = action;
  request.fields['DealTypeId'] = dealTypeId.toString();
  request.fields['Title'] = title;
  request.fields['CategoryId'] = categoryId.toString();
  request.fields['SubCategoryId'] = subCategoryId.toString();
  request.fields['Description'] = description;
  request.fields['IsDraft'] = isDraft.toString();
  request.fields['DealLong'] = dealLong.toString();
  request.fields['DealLat'] = dealLat.toString();
  request.fields['ShippingId'] = shippingId.toString();
  request.fields['UserId'] = userId;
  request.fields['IsFeatured'] = isFeatured.toString();
  request.fields['IsPremium'] = isPremium.toString();
  request.fields['IsTeverPick'] = isTeverPick.toString();
  request.fields['HasPromotion'] = hasPromotion.toString();
  request.fields['Price'] = price.toString();
  request.fields['IsBarter'] = isBarter.toString();
  request.fields['CurrencyName'] = currencyName;
  request.fields['CurrencyId'] = currencyId.toString();
  request.fields['PricingType'] = pricingType.toString();
  request.fields['PriceIndicator'] = priceIndicator;

  // Add image file
  final coverImageStream = http.ByteStream(coverImage.openRead());
  final coverImageLength = await coverImage.length();
  final coverImageMultipart = http.MultipartFile(
    'CoverImage', // Backend expects this key
    coverImageStream,
    coverImageLength,
    filename: coverImage.path.split('/').last,
  );
  request.files.add(coverImageMultipart);

  try {
    // Send request
    final response = await request.send();

    // Handle response
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      print('Upload successful: $responseData');
    } else {
      print('Failed to upload: ${response.statusCode}');
    }
  } catch (e) {
    print('Error uploading deal: $e');
  }
}
