import 'package:flutter/material.dart';
import 'package:tever/view/widgets/leader_board_screen/leaderboard_sucessstories_empty_state.dart';

class SuccessStoriesEmptyState extends StatelessWidget {
  const SuccessStoriesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const LeaderboardSucessstoriesEmptyState(
      btnText: "Share Your Story",
      image: "success_stories.png",
      title: "No stories yet",
      subTitle:
          "Let others see how the how the Referral and Earn program have impacted you .",
    );
  }
}
