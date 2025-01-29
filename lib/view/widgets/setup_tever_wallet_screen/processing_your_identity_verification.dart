import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/rotate_image.dart';

class ProcessingYourIdentityVerification extends StatelessWidget {
  const ProcessingYourIdentityVerification({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              const RotateImage(
                  imageHeight: 72,
                  imageUrl: "assets/icon/hour_glass.png",
                  imageWidth: 72),
              const SizedBox(height: 24),
              Text(
                "Processing your identity\nverification...",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.2,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: theme.primaryColor),
              ),
              const SizedBox(height: 20),
              Text(
                "Verification is in progress. You will be notified as soon as your identity has been verified successfully.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _customColor.custom242424),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
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
              "Back Home",
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
