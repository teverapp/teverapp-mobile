import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/complete_your_profile_screen.dart';
import 'package:tever/view/screens/profile_details_screen.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/screens/wallet_screen.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/tabs/more_tab/profile_button.dart';

class Personal extends ConsumerWidget {
  const Personal({super.key});

  void _showToast(
      {required BuildContext context, required String errorMessage}) {
    ToastService.showToast(
      context: context,
      message: errorMessage,
      status: ToastStatus.error.name,
    );
  }

  void _navigateToScreen(
      {required Widget screen,
      required BuildContext context,
      required String? errorMessage}) {
    if (errorMessage != null) {
      _showToast(context: context, errorMessage: errorMessage);
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final userData = ref.watch(userDataProvider);

    final authInfo = ref.read(authProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Personal",
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
              ProfileButton(
                  onTap: () => _navigateToScreen(
                      errorMessage: authInfo.isGuest
                          ? "Please login to view profile details"
                          : userData.firstName == null
                              ? "Please complete your profile view profile details"
                              : null,
                      context: context,
                      screen: authInfo.isGuest
                          ? const SignInScreen()
                          : userData.firstName == null
                              ? const CompleteYourProfileScreen()
                              : const ProfileDetailsScreen()),
                  icon: "profile_gray.png",
                  title: "Profile details"),
              const SizedBox(height: 8),
              const ProfileButton(
                icon: "location_darker.png",
                title: "Addresses",
                subTitle: "0",
              ),
              const SizedBox(height: 8),
              ProfileButton(
                onTap: () => _navigateToScreen(
                    errorMessage: authInfo.isGuest
                        ? "Please login to view your wallet"
                        : userData.firstName == null
                            ? "Please complete your profile view your wallet"
                            : null,
                    context: context,
                    screen: authInfo.isGuest
                        ? const SignInScreen()
                        : userData.firstName == null
                            ? const CompleteYourProfileScreen()
                            : const WalletScreen()),
                icon: "wallet_dark.png",
                title: "Wallet",
              ),
            ],
          ),
        )
      ],
    );
  }
}
