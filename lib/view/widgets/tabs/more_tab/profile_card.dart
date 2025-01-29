import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/complete_your_profile_screen.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/screens/sign_up_screen.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  final CustomColors _customColor = const CustomColors();

  void _navigate(Widget screen, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final theme = Theme.of(context);

    final userData = ref.watch(userDataProvider);

    final authInfo = ref.read(authProvider);

    final firstName = userData.firstName ?? "";
    final lastName = userData.lastName ?? "";

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: _customColor.customFDF7ED,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: statusBarHeight),
          const SizedBox(height: 18),
          Stack(clipBehavior: Clip.none, children: [
            Container(
              height: 80,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: _customColor.customF9E8CC),
              child: Image.asset(
                "assets/icon/profile_orange.png",
                height: 40,
                width: 40,
              ),
            ),
            Positioned(
              bottom: -1,
              right: -1,
              child: Container(
                alignment: Alignment.center,
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: _customColor.customF9E8CC,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: _customColor.customFDF7ED,
                  ),
                ),
                child: Image.asset(
                  "assets/icon/emoji_normal.png",
                  height: 12,
                  width: 12,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 16),
          if (!authInfo.isGuest)
            Text(
              firstName.isEmpty ? "Hello" : "$firstName $lastName",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _customColor.custom242424),
            ),
          const SizedBox(height: 4),
          if (authInfo.isGuest)
            RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Sign up",
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => _navigate(const SignUpScreen(), context)),
                    const TextSpan(
                      text: "/ ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                        text: "/ Log in",
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => _navigate(const SignInScreen(), context)),
                  ],
                  style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      fontFamily: 'Inter')),
            ),
          if (!authInfo.isGuest)
            if (firstName.isEmpty)
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const CompleteYourProfileScreen()),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Complete your profile",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryColor),
                    ),
                    const SizedBox(width: 4),
                    Image.asset("assets/icon/arrow_right_orange_thin.png",
                        height: 20, width: 20),
                  ],
                ),
              ),
          if (firstName.isNotEmpty)
            Container(
              height: 24,
              decoration: BoxDecoration(
                  color: _customColor.customF5FD99,
                  borderRadius: BorderRadius.circular(100)),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/icon/tever_icon.png",
                      height: 12, width: 12),
                  const SizedBox(width: 4),
                  Text(
                    "0",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _customColor.custom242424),
                  )
                ],
              ),
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
