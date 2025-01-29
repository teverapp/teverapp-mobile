import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class ProfileButton extends StatelessWidget {
  final String icon;
  final String title;
  final String? subTitle;
  final VoidCallback? onTap;
  const ProfileButton(
      {super.key,
      required this.icon,
      required this.title,
      this.subTitle,
      this.onTap});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: _customColor.customEFEFEF))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/icon/$icon",
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                if (subTitle != null)
                  const SizedBox(
                    width: 8,
                  ),
                if (subTitle != null)
                  Container(
                    height: 20,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: theme.primaryColor),
                    ),
                    child: Text(
                      subTitle.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryColor),
                    ),
                  )
              ],
            ),
            Image.asset(
              "assets/icon/arrow_right_darker.png",
              height: 20,
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
