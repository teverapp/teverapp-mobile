import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class TrendingOnTrevor extends StatelessWidget {
  const TrendingOnTrevor({super.key});

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
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          "Trending on Tever",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _customColor.custom2572A4),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "OBO is coming to your city",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _customColor.custom242424),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Davido's concert is happening live in Lagos on X from 10pm till dawn. Grab yours now!",
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: _customColor.custom5D5D5D),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              SizedBox(
                  height: 28,
                  child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 0),
                          backgroundColor: theme.primaryColor),
                      child: const Text(
                        "Get ticket!",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )))
            ],
          ),
        )
      ],
    );
  }
}
