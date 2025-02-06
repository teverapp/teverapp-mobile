import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class CheckAndConfirmCard extends StatelessWidget {
  final String label;
  final String? value;
  final File? image;
  final bool? showBottomMargin;

  const CheckAndConfirmCard(
      {super.key,
      required this.label,
      this.value,
      this.image,
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
            if (image != null)
              Container(
                alignment: Alignment.center,
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _customColor.customEFEFEF,
                    border:
                        Border.all(width: 1, color: _customColor.customE7E7E7)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            if (value != null)
              Expanded(
                  child: Text(
                value.toString(),
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
