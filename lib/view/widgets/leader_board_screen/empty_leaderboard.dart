import 'package:flutter/material.dart';
import 'package:tever/view/widgets/leader_board_screen/leaderboard_sucessstories_empty_state.dart';

class EmptyLeaderboard extends StatelessWidget {
  const EmptyLeaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const LeaderboardSucessstoriesEmptyState(
      btnText: "Start referring",
      image: "leaderboard_star.png",
      title: "No leaders yet",
      subTitle:
          "The leaderboard is waiting for its first champion. Refer and earn to claim your spot.",
    );
  }
}
