import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class LocationAndTiming extends StatelessWidget {
  final bool useFullRadius;
  const LocationAndTiming({
    super.key,
    required this.useFullRadius,
  });

  final CustomColors _customColor = const CustomColors();

  Widget _buildCard({required String icon, required String label}) {
    return Row(
      children: [
        Image.asset(
          "assets/icon/$icon",
          height: 16,
          width: 16,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: _customColor.custom888888),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: useFullRadius ? 27 : 0, bottom: 27, left: 16, right: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft:
                    useFullRadius ? const Radius.circular(24) : Radius.zero,
                topRight:
                    useFullRadius ? const Radius.circular(24) : Radius.zero,
                bottomRight: const Radius.circular(24),
                bottomLeft: const Radius.circular(24))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Venue, date and time",
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
            const SizedBox(height: 10),
            _buildCard(
                icon: "calendar_gray.png",
                label: "Dec 12 - Dec 13 18:00 - 6:00 AM"),
            const SizedBox(height: 20),
            _buildCard(
                icon: "location_gray_dark.png",
                label: "58. Aibu Street, Surulere. Lagos. Nigeria"),
            const SizedBox(height: 20),
            _buildCard(
                icon: "global.png", label: "GMT + 1:00 West African Time")
          ],
        ));
  }
}
