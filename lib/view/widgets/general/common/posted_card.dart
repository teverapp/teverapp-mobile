import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tever/helpers/custom_colors.dart';

class PostedCard extends StatelessWidget {
  final String approvalStatus;
  final String promotionCode;
  final String title;
  final String price;
  final String slashedPrice;
  final VoidCallback onTap;
  const PostedCard({
    super.key,
    required this.approvalStatus,
    required this.promotionCode,
    required this.title,
    required this.price,
    required this.slashedPrice,
    required this.onTap,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    double formattedPrice = double.tryParse(price) ?? 0.0;

    double formattedSlashedPrice = double.tryParse(slashedPrice) ?? 0.0;

    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Approval status",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: _customColor.custom242424,
                  ),
                ),
                Text(
                  approvalStatus,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: _customColor.custom4F4F4F,
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Promotion Code",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: _customColor.custom4F4F4F,
                  ),
                ),
                Text(
                  promotionCode,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: _customColor.custom888888,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  "assets/image/get_started_image.png",
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424,
              ),
            ),
            const SizedBox(height: 5),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "₦${NumberFormat.decimalPattern().format(formattedPrice)}  ",
                        style: TextStyle(
                          fontSize: 16,
                          color: _customColor.custom242424,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text:
                            "₦${NumberFormat.decimalPattern().format(formattedSlashedPrice)}",
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
              const SizedBox(
                width: 4,
              ),
              Container(
                margin: const EdgeInsets.only(top: 3),
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
            ]),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: onTap,
                  style: OutlinedButton.styleFrom(
                    side:
                        BorderSide(color: _customColor.custom242424, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "See more",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _customColor.custom242424,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        //Change image color
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            _customColor.custom242424,
                            BlendMode.srcATop,
                          ),
                          child: Image.asset(
                            "assets/icon/arrow_right_dark_thick.png",
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ])),
            ),
          ],
        ));
  }
}
