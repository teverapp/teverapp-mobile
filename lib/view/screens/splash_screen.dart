import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/access_token_controller.dart';
import 'package:tever/controller/app_info_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/get_started_screen.dart';
import 'package:tever/view/screens/onboarding_screen.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/screens/tabs_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
  }

  Future<void> _navigateBasedOnState() async {
    final prefs = await SharedPreferences.getInstance();

    // Check if the app is opened for the first time
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // Mark the app as opened
      await prefs.setBool('isFirstTime', false);

      _navigateToScreen(const OnboardingScreen());

      return;
    }

    // Check if token exists in shared preferences
    final token = ref.read(accessTokenProvider);
    if (token.isEmpty) {
      _navigateToScreen(const SignInScreen());
    } else {
      _navigateToScreen(const TabsScreen());
    }
  }

  _navigateToNewScreen(Widget screen) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _navigateToScreen(Widget screen) async {
    await Future.delayed(const Duration(seconds: 3));
    _navigateToNewScreen(screen);
  }

  Future<void> _initializeData() async {
    try {
      await ref.read(accessTokenProvider.notifier).initializeAccessToken();

      print("initializeSelectedCountry");
      await ref.read(appInfoProvider.notifier).initializeSelectedCountry();

      _navigateBasedOnState();
    } catch (error) {
      // Propagate the error to FutureBuilder
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme.primaryColor,
      body: Center(
          child: FutureBuilder(
        future: _initializeData(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Image.asset(
              "assets/logo/logo_dark.png",
              height: 46,
              width: 177.84,
            );
          } else if (dataSnapShot.hasError) {
            return const Center(
                child: Text(
              "Something went wrong!",
              style: TextStyle(color: Colors.white),
            ));
          } else {
            return Image.asset(
              "assets/logo/logo_dark.png",
              height: 46,
              width: 177.84,
            );
          }
        },
      )),
    );
  }
}
