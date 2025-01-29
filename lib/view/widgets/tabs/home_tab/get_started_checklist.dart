import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/complete_your_profile_screen.dart';
import 'package:tever/view/screens/create_your_business_profile_screen.dart';
import 'package:tever/view/screens/setup_tever_wallet_screen.dart';

class GetStartedChecklist extends ConsumerWidget {
  const GetStartedChecklist({super.key});

  final CustomColors _customColors = const CustomColors();

  Widget _buildCard(
      {required bool isCompleted,
      required String title,
      required String subTitle,
      required String icon,
      required Color iconBgColor,
      VoidCallback? onTap}) {
    return GestureDetector(
        onTap: isCompleted ? null : onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isCompleted ? _customColors.customFAFAFA : Colors.transparent,
            border: isCompleted
                ? null
                : Border.all(width: 1, color: _customColors.customEFEFEF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 34,
                      width: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: iconBgColor),
                      child: Image.asset(
                        "assets/icon/$icon",
                        height: 16,
                        width: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: _customColors.custom242424),
                          ),
                          Text(
                            subTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: _customColors.custom6D6D6D),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Image.asset(
                isCompleted
                    ? "assets/icon/done.png"
                    : "assets/icon/arrow_right.png",
                height: isCompleted ? 24 : 20,
                width: isCompleted ? 24 : 20,
              )
            ],
          ),
        ));
  }

  void _navigate(Widget screen, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    final bool isProfileComplete =
        userData.isEmailVerified! && userData.isPhoneNumberVerified!;

    return Container(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Getting started checklist",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _customColors.custom242424),
              ),
              GestureDetector(
                onTap: () => ref
                    .read(userDataProvider.notifier)
                    .updateField("hasSetupCheckList", true),
                child: Image.asset("assets/icon/close_circle_thin.png",
                    height: 20, width: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildCard(
              onTap: () =>
                  _navigate(const CompleteYourProfileScreen(), context),
              isCompleted: isProfileComplete,
              iconBgColor: isProfileComplete
                  ? _customColors.customD2F9E7
                  : _customColors.customE5F0F9,
              icon: isProfileComplete ? "profile.png" : "profile_blue.png",
              title: isProfileComplete
                  ? "Profile completed"
                  : "Complete your profile",
              subTitle:
                  isProfileComplete ? "Awesome!" : "Let’s get to know you"),
          const SizedBox(height: 8),
          _buildCard(
              onTap: () => _navigate(const SetupTeverWalletScreen(), context),
              isCompleted: false,
              icon: "wallet.png",
              iconBgColor: _customColors.customE5F0F9,
              title: "Set up your Tever wallet",
              subTitle: "Complete KYC to start using wallet"),
          const SizedBox(height: 8),
          _buildCard(
              onTap: () =>
                  _navigate(const CreateYourBusinessProfileScreen(), context),
              isCompleted: false,
              icon: "shop_add.png",
              iconBgColor: _customColors.customE5F0F9,
              title: "Add a business",
              subTitle: "Set up an online storefront"),
        ],
      ),
    );
  }
}
