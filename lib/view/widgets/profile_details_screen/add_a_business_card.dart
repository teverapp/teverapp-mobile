import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/create_your_business_profile_screen.dart';

class AddABusinessCard extends StatelessWidget {
  const AddABusinessCard({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const CreateYourBusinessProfileScreen(
                  isCreatedFromNewDeals: true,
                )),
      ),
      child: Container(
        width: double.infinity,
        height: 155,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: _customColor.customE5F0F9),
              child: Image.asset(
                "assets/icon/shop_add.png",
                height: 16,
                width: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Add a business",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Set up an online storefront",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: _customColor.custom6D6D6D,
              ),
            )
          ],
        ),
      ),
    );
  }
}
