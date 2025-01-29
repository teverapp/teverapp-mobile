import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class FacialMatching extends StatefulWidget {
  const FacialMatching({super.key});

  @override
  State<FacialMatching> createState() => _FacialMatchingState();
}

class _FacialMatchingState extends State<FacialMatching> {
  final CustomColors _customColor = const CustomColors();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(
          "Facial Matching",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 14),
        Text(
          "Take a selfie",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 40),
        Text(
          "Headshot",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 10),
        Container(
          height: 240,
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _customColor.customFAFAFA,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icon/camera.png",
                  height: 24,
                  width: 24,
                ),
                const SizedBox(height: 16),
                Text(
                  "Start camera",
                  style: TextStyle(
                      fontSize: 14,
                      color: _customColor.custom888888,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _customColor.custom888888, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              "Next",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _customColor.custom888888,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
