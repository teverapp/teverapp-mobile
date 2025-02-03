import 'package:flutter/material.dart';

import 'package:tever/view/widgets/tabs/more_tab/profile_button.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  void _navigate(Widget screen, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Services",
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
          child: const Column(
            children: [
              ProfileButton(
                icon: "flash_dark.png",
                title: "Hot deals",
              ),
              SizedBox(height: 8),
              ProfileButton(
                icon: "calendar_gray.png",
                title: "Events",
              ),
              SizedBox(height: 8),
              ProfileButton(
                icon: "location_darker.png",
                title: "Spaces",
              ),
              SizedBox(height: 8),
              ProfileButton(
                icon: "refresh.png",
                title: "Barter",
              ),
              SizedBox(height: 8),
              ProfileButton(
                icon: "chart.png",
                title: "Analytics",
              ),
            ],
          ),
        )
      ],
    );
  }
}
