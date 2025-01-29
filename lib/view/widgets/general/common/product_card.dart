import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/product_item_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  final CustomColors _customColor = const CustomColors();

  Widget _buildButton(
      {String? label, required String icon, required VoidCallback ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        children: [
          Image.asset(
            "assets/icon/$icon",
            height: 20,
            width: 20,
          ),
          if (label != null) const SizedBox(width: 2),
          if (label != null)
            Text(
              label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.customBDBDBD),
            )
        ],
      ),
    );
  }

  _productDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ProductItemDetailsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: _customColor.customEFEFEF),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Source",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: _customColor.custom4F4F4F),
              ),
              Text(
                "1 day ago",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: _customColor.custom888888),
              )
            ],
          ),
          const SizedBox(height: 12),
          Stack(children: [
            SizedBox(
              height: 126,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  "assets/image/trending_image_placeholder.png",
                  height: 126,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                    color: _customColor.customE7F84A,
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  "30% off",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: _customColor.custom242424),
                ),
              ),
            )
          ]),
          const SizedBox(height: 12),
          Text(
            "A two-line sentence for name of item A two-line sentence for name of item A two-line sentence for name of item A two-line sentence for name of item",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: _customColor.custom4F4F4F),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: "₦7,000  ",
                      style: TextStyle(
                        fontSize: 16,
                        color: _customColor.custom242424,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "₦10,000",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom888888,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: _customColor.custom888888,
                        decorationThickness: 2.0,
                      ),

                      //
                    ),
                  ],
                  style: TextStyle(
                      color: _customColor.custom4F4F4F,
                      fontSize: 14,
                      height: 1.3,
                      fontFamily: 'Inter')),
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Store/ Brand name",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom888888),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 46,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: _customColor.customEFEFEF),
                top: BorderSide(width: 1, color: _customColor.customEFEFEF),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildButton(label: "20", icon: "like.png", ontap: () {}),
                const SizedBox(width: 2),
                _buildButton(label: "2", icon: "message.png", ontap: () {}),
                const SizedBox(width: 2),
                _buildButton(icon: "send.png", ontap: () {})
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: TextButton(
              onPressed: () => _productDetails(context),
              style: TextButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  "assets/icon/shopping_cart_orange.png",
                  height: 20,
                  width: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Buy now",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
