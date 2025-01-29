import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class PointsEarned extends StatelessWidget {
  const PointsEarned({super.key});

  final CustomColors _customColor = const CustomColors();

  Widget _buildLeaderBoardCard({required String label, required String value}) {
    return Column(children: [
      Text(
        value,
        textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _customColor.custom242424),
      ),
      const SizedBox(height: 20),
      Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: _customColor.custom15B488),
      ),
      const SizedBox(height: 20),
      Container(
        height: 24,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: _customColor.customF5FD99),
        child: Row(
          children: [
            Image.asset("assets/icon/emoji_smile.png", height: 16, width: 16),
            const SizedBox(
              width: 2,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom57660E),
            )
          ],
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _customColor.custom292929),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/icon/gift.png",
                height: 24,
                width: 24,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Refer friends, earn points and profile badges",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _customColor.custom242424),
                ),
                const SizedBox(height: 3),
                Text(
                  "Share your referral link with your friends and colleagues to earn free points.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: _customColor.custom6D6D6D),
                )
              ],
            ))
          ],
        ),
        const SizedBox(
          height: 19,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: _customColor.customEFEFEF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Unlock new profile badges when you earn more points",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: _customColor.custom242424),
              ),
              const SizedBox(height: 2),
              Text(
                "Enjoy monthly benefits when you unlock new profile badges by referring people to sign up on Tever.",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom6D6D6D,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                "Points earned".toUpperCase(),
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _customColor.custom242424),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Stack(
                    children: [
                      Positioned(
                          bottom: 48,
                          right: 0,
                          left: 0,
                          child: Container(
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: _customColor.customEFEFEF),
                          )),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 14,
                            ),
                            _buildLeaderBoardCard(label: "Newbie", value: "0"),
                            const Spacer(),
                            _buildLeaderBoardCard(
                                label: "Comrade", value: "1,000"),
                            const Spacer(),
                            _buildLeaderBoardCard(
                                label: "Odogwu", value: "10,000"),
                            const SizedBox(
                              width: 14,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Profile badge earned".toUpperCase(),
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _customColor.custom242424),
              ),
            ],
          ),
        )
      ],
    );
  }
}
