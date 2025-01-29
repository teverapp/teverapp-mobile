import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_screen/empty_state.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent activities",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          //Should show when recent activities is empty
          // const EmptyState()
          Container(
            padding: const EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: _customColor.customEFEFEF,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search credits earned",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom4F4F4F,
                      ),
                    ),
                    Text(
                      "Next level unlocked",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _customColor.custom965CF6,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "25/10/2024; 06:46pm",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom4F4F4F,
                      ),
                    )
                  ],
                ),
                Text(
                  "50 points",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _customColor.custom4F4F4F,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
