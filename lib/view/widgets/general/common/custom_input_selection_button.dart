import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class CustomInputSelectionButton extends StatefulWidget {
  final String selectedItem;
  final bool hasSelected;
  final double? bottomSheetHeight;
  final VoidCallback onTap;
  final String? imageUrl;

  const CustomInputSelectionButton(
      {super.key,
      required this.selectedItem,
      required this.hasSelected,
      this.bottomSheetHeight = 96,
      required this.onTap,
      this.imageUrl});

  @override
  State<CustomInputSelectionButton> createState() =>
      _CustomInputSelectionButtonState();
}

class _CustomInputSelectionButtonState
    extends State<CustomInputSelectionButton> {
  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: _customColor.customEFEFEF,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            if (widget.imageUrl != null) ...[
              Image.asset(
                widget.imageUrl.toString(),
                height: 16,
                width: 16,
              ),
              const SizedBox(
                width: 12,
              )
            ],
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Text(
                    widget.selectedItem,
                    style: TextStyle(
                      color: !widget.hasSelected
                          ? _customColor.custom888888
                          : _customColor.custom242424,
                      fontSize: 14,
                    ),
                  ),
                  Image.asset(
                    "assets/icon/drop_down.png",
                    height: 16,
                    width: 16,
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
