import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/view/screens/ads_details_screen.dart';
import 'package:tever/view/screens/bank_transfer_screen.dart';
import 'package:tever/view/screens/complete_your_profile_screen.dart';
import 'package:tever/view/screens/create_your_business_profile_screen.dart';
import 'package:tever/view/screens/error_screen.dart';
import 'package:tever/view/screens/event_published_successfully_screen.dart';
import 'package:tever/view/screens/forgot_password_screen.dart';
import 'package:tever/view/screens/get_started_screen.dart';
import 'package:tever/view/screens/leader_board_screen.dart';
import 'package:tever/view/screens/new_deal_screen.dart';
import 'package:tever/view/screens/new_event_screen.dart';
import 'package:tever/view/screens/onboarding_screen.dart';
import 'package:tever/view/screens/otp_screen.dart';
import 'package:tever/view/screens/password_reset_successfully_screen.dart';
import 'package:tever/view/screens/splash_screen.dart';
import 'package:tever/view/screens/waiting_screen.dart';
import 'package:tever/view/screens/product_item_details_screen.dart';
import 'package:tever/view/screens/profile_details_screen.dart';
import 'package:tever/view/screens/reset_password_screen.dart';
import 'package:tever/view/screens/setup_tever_wallet_screen.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/screens/sign_up_screen.dart';
import 'package:tever/view/screens/tabs_screen.dart';
import 'package:tever/view/screens/wallet_details_screen.dart';
import 'package:tever/view/screens/wallet_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  await Future.delayed(
    const Duration(seconds: 1),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tever',
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        primaryColor: const Color(0xFFE1781F),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF348EC3),
            // secondary: const Color(0xFFF5D0B7),
            error: const Color(0xFFD23130)),
        useMaterial3: true,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE1781F),
          selectionColor: Color(0xFFE1781F),
          selectionHandleColor: Color(0xFFE1781F),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return const Color(0xFFE1781F).withOpacity(0.2);
                }
                return null;
              },
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return const Color(0xFFE1781F).withOpacity(0.2);
                }
                return null;
              },
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return const Color(0xFFE1781F).withOpacity(0.2);
              }
              return null;
            }),
          ),
        ),
      ),
      home: NewEventScreen(),
    );
  }
}
