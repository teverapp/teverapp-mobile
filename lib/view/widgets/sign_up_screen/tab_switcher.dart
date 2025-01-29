import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class TabSwitcher extends StatelessWidget {
  final int activeSection;
  final Function(int) onTap;

  const TabSwitcher({
    super.key,
    required this.activeSection,
    required this.onTap,
  });

  final CustomColors _customColor = const CustomColors();

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required int activeIndex,
    required Function(int) onTap,
  }) {
    final theme = Theme.of(context);
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: activeSection == activeIndex
                  ? theme.primaryColor
                  : Colors.transparent,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () => onTap(activeIndex),
          style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: activeSection == activeIndex
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: activeSection == activeIndex
                  ? theme.primaryColor
                  : _customColor.customB0B0B0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          _buildButton(
            onTap: onTap,
            activeIndex: 0,
            context: context,
            label: "Phone",
          ),
          _buildButton(
            onTap: onTap,
            activeIndex: 1,
            context: context,
            label: "Email",
          ),
        ],
      ),
    );
  }
}
