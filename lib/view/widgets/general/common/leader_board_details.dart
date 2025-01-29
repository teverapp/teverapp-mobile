import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class LeaderBoardDetails extends StatelessWidget {
  const LeaderBoardDetails({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _leaderBoard = [
      {
        "label": "Total invites sent",
        "value": "0",
        "bgColor": _customColor.customFAFAFA
      },
      {
        "label": "Total successful referrals",
        "value": "0",
        "bgColor": _customColor.customF3F7FC
      },
      {
        "label": "Total points earned",
        "value": "0",
        "bgColor": _customColor.customEDFCF6
      }
    ];

    return SizedBox(
      height: 120,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _leaderBoard
              .map((leader) => Container(
                    width: 148,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: leader["bgColor"],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          leader["value"],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: _customColor.custom242424,
                          ),
                        ),
                        const SizedBox(height: 13),
                        Text(
                          leader["label"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Anybody",
                              fontWeight: FontWeight.w500,
                              color: _customColor.custom888888),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
