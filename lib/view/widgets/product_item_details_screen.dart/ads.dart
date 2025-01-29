import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class Ads extends StatelessWidget {
  const Ads({super.key});

  final CustomColors _customColor = const CustomColors();

  final List<String> _ratingPlaceHolder = const ["", "", "", ""];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: _customColor.customFDE3E3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Safety",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.error),
              ),
              const SizedBox(height: 7),
              Text(
                "Report this ad",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom420D0D,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                "A short description on the importance of reporting an ad that seems inappropriate or the seller/ service provider appears fraudulent or there has been any form of harassments.",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _customColor.custom4F4F4F),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icon/caution.png",
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Report this ad",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                      ]),
                ),
              ),
            ],
          )),
      const SizedBox(height: 8),
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _customColor.customFEFFE6,
        ),
        height: 224,
        child: Text(
          "Ads",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _customColor.customB0B0B0,
          ),
        ),
      ),
    ]);
  }
}
