import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class CheckAndConfirmCard extends StatelessWidget {
  final String label;
  final String value;
  final bool? showBottomMargin;

  const CheckAndConfirmCard(
      {super.key,
      required this.label,
      required this.value,
      this.showBottomMargin = true});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 37,
        margin: showBottomMargin! ? const EdgeInsets.only(bottom: 10) : null,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1,
          color: _customColor.customEFEFEF,
        ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: _customColor.custom242424),
            ))
          ],
        ),
      ),
    );
  }
}
