import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/tabs_screen.dart';
import 'package:tever/view/widgets/general/common/enter_address_labeled_text_field.dart';
import 'package:tever/view/widgets/general/common/rotate_image.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/promote_as_tever_top_pick.dart';
import 'package:tever/view/widgets/sign_up_screen/email_input.dart';
import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';

class PreLiveCheck extends ConsumerStatefulWidget {
  const PreLiveCheck({super.key});

  @override
  ConsumerState<PreLiveCheck> createState() => _PreLiveCheckState();
}

class _PreLiveCheckState extends ConsumerState<PreLiveCheck> {
  final CustomColors _customColor = const CustomColors();

  void _navigate(Widget screen) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: _customColor.customEFEFEF)),
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            child: Column(
              children: [
                Image.asset(
                  "assets/icon/hour_glass.png",
                  height: 72,
                  width: 72,
                ),
                const SizedBox(height: 24),
                Text(
                  "Checking content before deal goes live...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.primaryColor,
                      fontFamily: "Anybody"),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Your deal is currently being reviewed for approval before it goes live. You will be notified as soon as it gets approved",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _customColor.custom242424,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 58,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          width: 1, color: _customColor.customEFEFEF)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Approval status",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        height: 26,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _customColor.customF6F6F6,
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Pending",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: _customColor.custom242424,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const PromoteAsTeverTopPick(),
                const SizedBox(height: 19),
                Container(
                  height: 25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: _customColor.customE5F0F9,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 1, color: _customColor.customEFEFEF)),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0)),
                    onPressed: () {},
                    child: Text(
                      "Upgrade to premium",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: OutlinedButton(
                onPressed: () {
                  _navigate(const TabsScreen(
                    refetchUserData: true,
                  ));
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.colorScheme.primary, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  "Close",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.primary,
                  ),
                )),
          ),
        ]));
  }
}
