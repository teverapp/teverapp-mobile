import 'package:flutter/material.dart';

import 'package:tever/helpers/custom_colors.dart';

class LeaderboardSucessstoriesEmptyState extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String btnText;
  const LeaderboardSucessstoriesEmptyState(
      {super.key,
      required this.btnText,
      required this.image,
      required this.title,
      required this.subTitle});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 500,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/image/$image",
            height: 140,
            width: 140,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _customColor.custom242424,
              fontFamily: "Anybody",
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 326),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom242424),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 48,
            width: 264,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                btnText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
