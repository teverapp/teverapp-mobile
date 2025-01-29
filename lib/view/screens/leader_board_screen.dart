import 'package:flutter/material.dart';

import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/leader_board_details.dart';
import 'package:tever/view/widgets/leader_board_screen/leader_board_search.dart';
import 'package:tever/view/widgets/leader_board_screen/leader_board_success_stories.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SafeArea(
              child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  height: 25,
                  width: 25,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: IconButton.styleFrom(padding: EdgeInsets.zero),
                    icon: Image.asset(
                      "assets/icon/arrow_left.png",
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Leaderboard",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424,
                      fontFamily: "Anybody"),
                )
              ],
            ),
          ))),
      body: SafeArea(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            color: _customColor.customF7F9FC,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const LeaderBoardSearch(),
                  const SizedBox(height: 20),
                  Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        bottom: 16,
                      ),
                      child: const LeaderBoardDetails()),
                  const LeaderBoardSuccessStories()
                ],
              ),
            )),
      ),
    );
  }
}
