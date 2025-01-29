import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class QuickAction extends StatelessWidget {
  const QuickAction({super.key});

  final CustomColors _customColor = const CustomColors();

  Widget buildCard(
      {required String icon,
      required String title,
      required Color bgColor,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: bgColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/icon/$icon",
                  height: 20,
                  width: 29,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: _customColor.custom242424),
                )
              ],
            ),
            Image.asset(
              "assets/icon/arrow_right_dark.png",
              height: 20,
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick actions",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _customColor.custom2572A4),
        ),
        const SizedBox(height: 16),
        buildCard(
          onTap: () {},
          icon: "flash.png",
          title: "Browse hot deals",
          bgColor: _customColor.customD2F9E7,
        ),
        const SizedBox(height: 8),
        buildCard(
          onTap: () {},
          icon: "location.png",
          title: "Discover events near you",
          bgColor: _customColor.customEFE9FE,
        ),
        const SizedBox(height: 8),
        buildCard(
          onTap: () {},
          icon: "shopping_cart.png",
          title: "Start selling",
          bgColor: _customColor.customFDE3E3,
        ),
      ],
    );
  }
}
