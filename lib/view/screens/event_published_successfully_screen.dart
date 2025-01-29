import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class EventPublishedSuccessfullyScreen extends StatelessWidget {
  const EventPublishedSuccessfullyScreen({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 90),
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      const SizedBox(width: double.infinity),
                      SizedBox(
                        height: 168,
                        width: 168,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/image/trending_image_placeholder.png",
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: -20,
                        child: Container(
                          height: 48,
                          width: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _customColor.customFDF7ED,
                            border:
                                Border.all(width: 1, color: theme.primaryColor),
                          ),
                          child: Image.asset(
                            "assets/icon/share.png",
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 104),
                  Text(
                    "Event published successfully",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _customColor.custom242424),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Congratulations! Your event is now live and visible to your audience.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom5D5D5D),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text(
                        "View event",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: _customColor.custom242424, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Text(
                          "Manage event",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _customColor.custom242424,
                          ),
                        )),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
