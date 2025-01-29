import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/complete_your_profile_screen.dart';
import 'package:tever/view/screens/new_deal_screen.dart';
import 'package:tever/view/screens/new_event_screen.dart';
import 'package:tever/view/screens/profile_details_screen.dart';
import 'package:tever/view/screens/sign_in_screen.dart';

class Welcome extends ConsumerWidget {
  const Welcome({super.key});

  final CustomColors _customColors = const CustomColors();

  void _navigate({required Widget screen, required BuildContext context}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  Widget buildCard(
      {required String title,
      required String subTitle,
      required Color cardColor,
      required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: cardColor, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _customColors.custom242424),
              ),
              const SizedBox(height: 6),
              Text(
                subTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: _customColors.custom5D5D5D),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    final authInfo = ref.read(authProvider);

    final firstName = userData.firstName ?? "";

    final completedFirstName =
        firstName.isEmpty ? "Welcome," : "Welcome $firstName,";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  completedFirstName,
                  style: TextStyle(
                      fontSize: 20,
                      color: _customColors.custom242424,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Anybody"),
                ),
                Text(
                  "What would you like to do today?",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _customColors.custom6D6D6D),
                )
              ],
            ),
            Row(
              children: [
                Image.asset("assets/icon/chat.png", height: 20, width: 20),
                const SizedBox(width: 16),
                Image.asset("assets/icon/notification_bing.png",
                    height: 20, width: 20),
              ],
            )
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            buildCard(
                onTap: () => _navigate(
                    screen: authInfo.isGuest
                        ? const SignInScreen()
                        : userData.firstName == null
                            ? const CompleteYourProfileScreen()
                            : const NewDealScreen(),
                    context: context),
                title: "Create a deal",
                subTitle: "Promote an experience, a service or an item",
                cardColor: _customColors.customF9E8CC),
            const SizedBox(width: 8),
            buildCard(
                onTap: () => _navigate(
                    screen: authInfo.isGuest
                        ? const SignInScreen()
                        : userData.firstName == null
                            ? const CompleteYourProfileScreen()
                            : const NewEventScreen(),
                    context: context),
                title: "Create event",
                subTitle: "Organize and promote events without hassle",
                cardColor: _customColors.customE5F0F9),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
