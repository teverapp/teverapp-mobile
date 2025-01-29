import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_info_controller.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/country.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/screens/sign_up_screen.dart';
import 'package:tever/view/screens/tabs_screen.dart';
import 'package:tever/view/widgets/get_started_sreen/country_bottom_sheet.dart';
import 'package:tever/view/widgets/get_started_sreen/country_drop_down.dart';

class GetStartedScreen extends ConsumerStatefulWidget {
  const GetStartedScreen({super.key});

  @override
  ConsumerState<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends ConsumerState<GetStartedScreen> {
  final CustomColors _customColor = const CustomColors();

  late String? _selectedCountry;

  late String? _selectedCountryEmoji;

  bool _loadedIntialData = false;

  bool _showCountryDropDown = false;

  void _continueAsGuest() {
    ref.read(authProvider.notifier).updateField("isGuest", true);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const TabsScreen()),
    );
  }

  void _navigate(Widget screen) {
    final authInfo = ref.watch(authProvider);

    print(
        "authInfo.countryCode.toString() ${authInfo.countryPhoneCode.toString()}");
    ref.read(appInfoProvider.notifier).setCountry(
          Country(
            name: authInfo.country.toString(),
            flag: authInfo.countryFlag.toString(),
            phoneCode: authInfo.countryPhoneCode.toString(),
            countryCode: authInfo.countryCode.toString(),
          ),
        );

    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }

  // void _showCountryDropDownHandler() {
  //   setState(() {
  //     _showCountryDropDown = !_showCountryDropDown;
  //   });
  // }

  void _selectCountry(Country country) {
    // _showCountryDropDownHandler();

    setState(() {
      _selectedCountry = country.name;

      _selectedCountryEmoji = country.flag;
    });

    ref.read(authProvider.notifier).updateField("country", country.name);

    ref.read(authProvider.notifier).updateField("countryFlag", country.flag);

    ref
        .read(authProvider.notifier)
        .updateField("countryCode", country.countryCode);

    ref
        .read(authProvider.notifier)
        .updateField("countryPhoneCode", country.phoneCode);
  }

  void _showCountryBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return CountryBottomSheet(onTap: _selectCountry);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedIntialData) {
      final authInfo = ref.watch(authProvider);

      _selectedCountry = authInfo.country;

      _selectedCountryEmoji = authInfo.countryFlag;

      _loadedIntialData = true;
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 324,
                width: double.infinity,
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/image/get_started_image.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                    child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          "assets/logo/logo_light.png",
                          width: 92.79,
                          height: 24,
                        ))),
              ),
              const SizedBox(height: 37),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Get started",
                      style: TextStyle(
                          fontFamily: "Anybody",
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                          color: _customColor.custom242424),
                    ),
                  ),
                  Text(
                    "Find the best sellers around the globe",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom5D5D5D),
                  ),
                  const SizedBox(height: 87),
                  SizedBox(
                    height: 272,
                    child: Column(children: [
                      GestureDetector(
                        onTap: _showCountryBottomSheet,
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: Container(
                            height: 56,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: _customColor.customFAFAFA,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    width: 1,
                                    color: _customColor.customEFEFEF)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 32,
                                            width: 32,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: OverflowBox(
                                                  maxWidth: double.infinity,
                                                  maxHeight: double.infinity,
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                      _selectedCountryEmoji ==
                                                              null
                                                          ? "🇳🇬"
                                                          : _selectedCountryEmoji
                                                              .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 53),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          const SizedBox(width: 16),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "I live in:",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: _customColor
                                                        .custom2E3438),
                                              ),
                                              const SizedBox(height: 1),
                                              Text(
                                                _selectedCountry ?? "Nigeria",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: _customColor
                                                        .custom2E3438),
                                              )
                                            ],
                                          )
                                        ]),
                                    AnimatedRotation(
                                      turns: _showCountryDropDown ? 0.5 : 0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Image.asset(
                                        "assets/icon/drop_down.png",
                                        height: 16,
                                        width: 16,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0)),
                            onPressed: () => _navigate(const SignUpScreen()),
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 1, color: _customColor.customEFEFEF)),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0)),
                          onPressed: () => _navigate(const SignInScreen()),
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 1, color: _customColor.custom242424)),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0)),
                          onPressed: _continueAsGuest,
                          child: Text(
                            "Continue as a guest",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _customColor.custom242424),
                          ),
                        ),
                      ),

                      // CountryDropDown(
                      //     onTap: _selectCountry,
                      //     showCountryDropDown: _showCountryDropDown)
                    ]),
                  ),
                  const SizedBox(height: 16),
                ]),
              ),
              const SizedBox(height: 87),
            ],
          ),
        )),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 24,
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image/patterns.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            )),
      ]),
    );
  }
}
