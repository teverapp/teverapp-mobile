import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_info_controller.dart';

import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/input_validation_controller.dart';
import 'package:tever/extensions/auth_status.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/model/auth.dart';
import 'package:tever/model/country.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/screens/otp_screen.dart';
import 'package:tever/view/screens/set_a_password_screen.dart';
import 'package:tever/view/widgets/general/authentication/authentication_layout.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/sign_up_screen/email_input.dart';
import 'package:tever/view/widgets/sign_up_screen/bottom_section.dart';
import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';
import 'package:tever/view/widgets/sign_up_screen/tab_switcher.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  int _activeSection = 0;

  bool _isLoading = false;

  bool _emailError = true;

  bool _phoneNumberError = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final InputValidationController _valdate = InputValidationController();

  final List<Widget> _sections = [];

  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _phoneKey =
      GlobalKey<FormFieldState<String>>();

  bool _loadedIntialData = false;

  void _selectSection(int index) {
    setState(() {
      _activeSection = index;
    });
  }

  void _navigate(Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  void _emailOnSaveHandler(String email) {
    print("email on save $email");
    ref.read(authProvider.notifier).updateField("email", email);
  }

  void _phoneNumberOnSaveHandler(String phoneNumber) {
    ref.read(authProvider.notifier).updateField("phoneNumber", phoneNumber);
  }

  void _emailValidator(bool hasError) {
    _emailError = hasError;
  }

  void _phoneNumberValidator(bool hasError) {
    _phoneNumberError = hasError;
  }

  Future<void> _onBoard() async {
    return ref.read(authProvider.notifier).onBoard();
  }

  Future<void> _resendOtp() async {
    return ref.read(authProvider.notifier).sendOnBoardOTP();
  }

  Future<void> _verifyOtp(String otp) async {
    await ref.read(authProvider.notifier).verifyOnBoardOtp(
          otp: otp,
          action: "onboard",
        );

    if (mounted) {
      _navigate(const SetAPasswordScreen());
    }
  }

  void _showToastAndNavigate(
      {required String message, required Widget screen}) {
    if (mounted) {
      ToastService.showToast(
        context: context,
        message: message,
        status: ToastStatus.info.name,
      );
      _navigate(screen);
    }
  }

  void _showErrorToast(String message) {
    if (mounted) {
      ToastService.showToast(
        context: context,
        message: message,
        status: ToastStatus.error.name,
      );
    }
  }

  Future<void> _handleContinue() async {
    bool isValid = false;

    print("submitted");

    if (_activeSection == 0) {
      _phoneKey.currentState?.validate() ?? false;

      isValid = !_phoneNumberError;
      if (isValid) {
        _phoneKey.currentState?.save();
      }
    } else if (_activeSection == 1) {
      _emailKey.currentState?.validate() ?? false;

      isValid = !_emailError;

      if (isValid) {
        _emailKey.currentState?.save();
      }
    }

    print(isValid);
    if (!isValid) {
      return;
    }

    String authState =
        _activeSection == 1 ? AuthStatus.email.value : AuthStatus.phone.value;
    print(authState);

    ref.read(authProvider.notifier).updateField("authType", authState);

    setState(() {
      _isLoading = true;
    });

    final Auth authData = ref.watch(authProvider);

    String title =
        _activeSection == 0 ? "Authenticate..." : "Verify email address";

    String subTitle = _activeSection == 0
        ? "A one-time passcode has been sent to your phone number ending with ${_valdate.getLastFourCharacters(authData.phoneNumber.toString())}"
        : "A verification code has been sent to your email address ${_valdate.maskEmail(authData.email.toString())}";

    try {
      await _onBoard();

      if (mounted) {
        _navigate(OtpScreen(
            verifyOtp: _verifyOtp,
            resendOtp: _resendOtp,
            title: title,
            subTitle: subTitle));
      }
    } on CustomHttpException catch (error) {
      final errorMessage = error.toString();
      String message =
          "It seems you started onboarding, welcome back, ...continue your signup process";

      if (errorMessage == AuthStatus.hasNotConfirmedEmail.value ||
          errorMessage == AuthStatus.hasNotConfirmedPhoneNumber.value) {
        _showToastAndNavigate(
            message: message,
            screen: OtpScreen(
              verifyOtp: _verifyOtp,
              resendOtp: _resendOtp,
              title: title,
              subTitle: subTitle,
            ));
      } else if (errorMessage == AuthStatus.hasNotSetPassword.value) {
        _showToastAndNavigate(
          message: message,
          screen: const SetAPasswordScreen(),
        );
      } else {
        print("called toast");
        _showErrorToast(errorMessage);
      }
    } catch (error) {
      String errorMessage = "Something went wrong!";

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }
      _showErrorToast(errorMessage);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedIntialData) {
      final authInfo = ref.watch(authProvider);

      ref.read(appInfoProvider.notifier).setCountry(
            Country(
                name: authInfo.country.toString(),
                flag: authInfo.countryFlag.toString(),
                phoneCode: authInfo.countryPhoneCode.toString(),
                countryCode: authInfo.countryCode.toString()),
          );

      _sections.addAll([
        PhoneInput(
            phoneKey: _phoneKey,
            validator: _phoneNumberValidator,
            onSave: _phoneNumberOnSaveHandler,
            selectedCountryAcronym: authInfo.countryCode.toString(),
            selectedCountryFlag: authInfo.countryFlag.toString(),
            selectedCountryPhoneCode: authInfo.countryPhoneCode.toString(),
            key: const ValueKey("phoneInput")),
        EmailInput(
          emailKey: _emailKey,
          onSave: _emailOnSaveHandler,
          key: const ValueKey("emailInput"),
          validator: _emailValidator,
        ),
      ]);

      _loadedIntialData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthenticationLayout(
      title: "Sign up",
      subTitle: "Create a Tever account to get started",
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TabSwitcher(
              activeSection: _activeSection,
              onTap: _selectSection,
            ),
            IndexedStack(
              index: _activeSection,
              children: _sections,
            ),
            BottomSection(
              normalAuthIsLoading: _isLoading,
              continueBtn: _handleContinue,
              authState: AuthStatus.signup.value,
              activeSection: _activeSection,
            ),
          ],
        ),
      ),
    );
  }
}
