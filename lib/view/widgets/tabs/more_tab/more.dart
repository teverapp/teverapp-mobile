import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

import 'package:tever/view/widgets/tabs/more_tab/profile_button.dart';

class More extends StatelessWidget {
  const More({super.key});

  void _navigate({required Widget screen, required BuildContext context}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "More",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            children: [
              const ProfileButton(
                icon: "gift_referrals.png",
                title: "Referrals",
              ),
              const SizedBox(height: 8),
              ProfileButton(
                icon: "love.png",
                iconColor: _customColor.custom242424,
                title: "Gift cards",
              ),
              const SizedBox(height: 8),
              const ProfileButton(
                icon: "information.png",
                title: "FAQs",
              ),
              const SizedBox(height: 8),
              const ProfileButton(
                icon: "message_question.png",
                title: "Support",
              ),
              const SizedBox(height: 8),
              const ProfileButton(
                icon: "shield_security.png",
                title: "Privacy & security",
              ),
              const SizedBox(height: 8),
              const ProfileButton(
                icon: "notification_bing.png",
                title: "Notifications & alerts",
              ),
              const SizedBox(height: 8),
              const ProfileButton(
                icon: "task.png",
                title: "Legal",
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "v1.0.0",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.customB0B0B0,
            ),
          ),
        )
      ],
    );
  }
}
