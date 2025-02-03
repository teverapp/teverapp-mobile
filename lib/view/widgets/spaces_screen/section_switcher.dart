import 'package:flutter/material.dart';

import 'package:tever/helpers/custom_colors.dart';

class SectionSwitcher extends StatelessWidget {
  final Function selectSection;
  final int selectedSection;
  const SectionSwitcher({
    super.key,
    required this.selectSection,
    required this.selectedSection,
  });

  final CustomColors _customColor = const CustomColors();

  Widget _buildCard({
    required bool isActive,
    required VoidCallback onTap,
    required String title,
    required ThemeData theme,
    required String icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: isActive ? theme.primaryColor : Colors.transparent,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Change image color
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                isActive
                    ? _customColor.custom242424
                    : _customColor.custom888888,
                BlendMode.srcATop,
              ),
              child: Image.asset(
                "assets/icon/$icon",
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? _customColor.custom242424
                    : _customColor.custom888888,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      height: 36,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCard(
            isActive: selectedSection == 0,
            onTap: () => selectSection(0),
            title: "Saved",
            theme: theme,
            icon: "love.png",
          ),
          const SizedBox(
            width: 20,
          ),
          _buildCard(
            isActive: selectedSection == 1,
            onTap: () => selectSection(1),
            title: "Posted",
            theme: theme,
            icon: "add_circle.png",
          ),
        ],
      ),
    );
  }
}
