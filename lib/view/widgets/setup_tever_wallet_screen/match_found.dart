import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class MatchFound extends StatelessWidget {
  const MatchFound({super.key});

  final CustomColors _customColor = const CustomColors();

  Widget _buildCard({required String label, required String value}) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: _customColor.customEFEFEF),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Image.asset("assets/icon/approved.png", height: 80, width: 80),
              const SizedBox(height: 24),
              _buildCard(label: "First name", value: "John"),
              const SizedBox(height: 8),
              _buildCard(label: "Last name", value: "Doe"),
              const SizedBox(height: 8),
              _buildCard(label: "Date of birth", value: "3 Nov, 1992"),
              const SizedBox(height: 24),
              Text(
                "Match found",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom242424),
              ),
              const SizedBox(height: 8),
              Text(
                "Congratulations! Your identity has been successfully verified. Please note that your verified identity will override your profile details on Tever",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _customColor.custom242424),
              ),
            ],
          ),
        ),
        const SizedBox(height: 64),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _customColor.custom242424, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              "View profile",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _customColor.custom242424,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
