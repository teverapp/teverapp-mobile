import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/leader_board_details.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          const LeaderBoardDetails(),
          const SizedBox(height: 16),
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: _customColor.custom242424,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Text(
                "Leaderboard",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
