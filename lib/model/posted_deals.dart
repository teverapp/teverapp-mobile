class PostedDeals {
  final String? id;
  final String? approvalStatus;
  final String? promotionCode;
  //final String? imageUrl;
  final String? title;
  final String? price;
  final String? slashedPrice;

  PostedDeals({
    required this.id,
    required this.approvalStatus,
    required this.promotionCode,
    // required this.imageUrl,
    required this.title,
    required this.price,
    required this.slashedPrice,
  });

  factory PostedDeals.fromJson(Map<String, dynamic> json) {
    final dynamic dealPromotion = json['dealPromotion'];
    final String promotionCode = dealPromotion != null &&
            dealPromotion['promotionCode'] != null &&
            dealPromotion['promotionCode'].toString().isNotEmpty
        ? dealPromotion['promotionCode'].toString()
        : "Not posted yet";

    return PostedDeals(
      id: json['id'].toString(),
      approvalStatus: json['isActive'] ? "Approved" : "Pending",
      promotionCode: promotionCode,
      // imageUrl: json['coverImage']?.toString() ?? "", // Handle null imageUrl
      title: json['title']?.toString(),
      price: json['price']?.toString(),
      slashedPrice: json['discountedPrice']?.toString(),
    );
  }
}
