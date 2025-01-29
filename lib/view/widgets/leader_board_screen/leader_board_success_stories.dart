import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/leader_board_screen/leader_board_section.dart';
import 'package:tever/view/widgets/leader_board_screen/success_stories_section.dart';

class LeaderBoardSuccessStories extends StatefulWidget {
  const LeaderBoardSuccessStories({super.key});

  @override
  State<LeaderBoardSuccessStories> createState() =>
      _LeaderBoardSuccessStoriesState();
}

class _LeaderBoardSuccessStoriesState extends State<LeaderBoardSuccessStories> {
  int _activeSection = 0;

  final CustomColors _customColor = const CustomColors();

  final List<Widget> _sections = const [
    LeaderBoardSection(),
    SuccessStoriesSection()
  ];

  void _selectSection(int index) {
    setState(() {
      _activeSection = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectSection(0),
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: _activeSection == 0
                              ? _customColor.custom242424
                              : _customColor.customFAFAFA,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              _activeSection == 0
                                  ? "assets/icon/leaderboard_active.png"
                                  : "assets/icon/leaderboard_inactive.png",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Leaderboard",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _activeSection == 0
                                      ? Colors.white
                                      : _customColor.custom242424),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectSection(1),
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: _activeSection == 1
                              ? _customColor.custom242424
                              : _customColor.customFAFAFA,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              _activeSection == 1
                                  ? "assets/icon/success_active.png"
                                  : "assets/icon/success_inactive.png",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Success stories",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _activeSection == 1
                                      ? Colors.white
                                      : _customColor.custom242424),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
          _sections[_activeSection]
        ],
      ),
    );
  }
}
