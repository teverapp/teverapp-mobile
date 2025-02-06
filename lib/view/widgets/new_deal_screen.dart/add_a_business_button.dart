import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/create_your_business_profile_screen.dart';

class AddABusinessButton extends StatelessWidget {
  const AddABusinessButton({super.key});

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
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: _customColor.customEFEFEF),
            borderRadius: BorderRadius.circular(12)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: _customColor.customE5F0F9),
                child: Image.asset(
                  "assets/icon/shop_add.png",
                  height: 16,
                  width: 16,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add a business",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424,
                    ),
                  ),
                  //  const SizedBox(height: 8),
                  Text(
                    "Set up an online storefront",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: _customColor.custom6D6D6D,
                    ),
                  )
                ],
              )
            ],
          ),
          Image.asset(height: 20, width: 20, "assets/icon/arrow_right.png")
        ]),
      ),
    );
  }
}
