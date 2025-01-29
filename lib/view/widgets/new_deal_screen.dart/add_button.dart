import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  const AddButton({
    super.key,
    required this.onTap,
    required this.label,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: _customColor.customEFEFEF)),
        child: Row(
          children: [
            Image.asset(
              "assets/icon/add_circle_orange.png",
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
