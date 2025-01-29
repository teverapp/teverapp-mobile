class CommonType {
  String? id;
  String name;
  String? imageUrl;
  String? courierShippingRate;
  String? courierEstimatedTime;

  CommonType({
    this.id,
    required this.name,
    this.imageUrl,
    this.courierEstimatedTime,
    this.courierShippingRate,
  });

  factory CommonType.fromJson(Map<String, dynamic> jsonData) {
    return CommonType(
        id: jsonData['id']?.toString() ??
            jsonData['categoryId']?.toString() ??
            '',
        name: jsonData['name'].toString(),
        imageUrl: jsonData["iconUrl"],
        courierEstimatedTime: jsonData["estimatedDelviery"],
        courierShippingRate: jsonData["rate"]);
  }
}
