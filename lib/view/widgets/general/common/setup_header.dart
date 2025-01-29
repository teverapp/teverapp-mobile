import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class SetupHeader extends StatelessWidget {
  final String title;
  final String? subTitle;
  const SetupHeader({super.key, required this.title, this.subTitle});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Anybody",
              fontWeight: FontWeight.w600,
              color: _customColor.custom242424),
        ),
        if (subTitle != null) const SizedBox(height: 7),
        if (subTitle != null)
          Text(
            subTitle.toString(),
            softWrap: true,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom5D5D5D),
          )
      ],
    );
  }
}
