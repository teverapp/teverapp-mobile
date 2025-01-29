import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/helpers/custom_colors.dart';

class Tags extends StatelessWidget {
  final String imageUrl;
  final String title;
  const Tags({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tags",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                Image.asset(
                  "assets/icon/edit.png",
                  height: 16,
                  width: 16,
                )
              ],
            ),
            const SizedBox(height: 15),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: _customColor.customFDF7ED,
                  border: Border.all(width: 1, color: theme.primaryColor),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Change image color
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      theme.primaryColor,
                      BlendMode.srcATop,
                    ),
                    child: Image.asset(
                      "assets/icon/$imageUrl",
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
