import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class About extends StatelessWidget {
  const About({super.key});

  final CustomColors _customColor = const CustomColors();

  final List<String> _ratingPlaceHolder = const ["", "", "", ""];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "About",
          style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Text(
          "Luxe Essentials",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 16),
        Text(
          "Luxe Essentials is a brand dedicated to offering timeless elegance and premium craftsmanship at accessible prices. Specializing in a curated collection of handbags and accessories, Luxe Essentials combines sophisticated design with everyday functionality. Each piece is thoughtfully crafted to enhance personal style while providing lasting quality. With a commitment to bringing affordable luxury to everyone, Luxe Essentials ensures that every customer can experience the perfect blend of fashion and practicality for any occasion.",
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
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                "assets/icon/call.png",
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                "View contact details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )
            ]),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: _customColor.customE5F0F9,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                "assets/icon/heart_blue.png",
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "Chat with seller",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.primary,
                ),
              )
            ]),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 48,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: theme.colorScheme.primary, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                "assets/icon/gps.png",
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "Get to physical location",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.primary,
                ),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
