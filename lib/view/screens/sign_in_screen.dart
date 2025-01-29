import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_info_controller.dart';

import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/input_validation_controller.dart';
import 'package:tever/extensions/auth_status.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/model/country.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/screens/forgot_password_screen.dart';
import 'package:tever/view/screens/otp_screen.dart';
import 'package:tever/view/screens/set_a_password_screen.dart';
import 'package:tever/view/screens/tabs_screen.dart';
import 'package:tever/view/widgets/general/authentication/authentication_layout.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/sign_up_screen/email_input.dart';
import 'package:tever/view/widgets/sign_up_screen/bottom_section.dart';
import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';
import 'package:tever/view/widgets/sign_up_screen/tab_switcher.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  int _activeSection = 0;

  bool _isLoading = false;

  bool _loadedIntialData = false;

  bool _emailError = true;

  bool _phoneNumberError = true;

  bool _passwordError = true;

  String? _userName;

  String? _password;

  final InputValidationController _valdate = InputValidationController();

  void _emailOnSaveHandler(String email) {
    print("email onsave $email");
    _userName = email;
  }

  void _phoneNumberOnSaveHandler(String phoneNumber) {
    _userName = phoneNumber;
  }

  void _passwordOnSaveHandler(String password) {
    _password = password;
  }

  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _phoneKey =
      GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();

  final List<Widget> _sections = [];

  void _emailValidator(bool hasError) {
    _emailError = hasError;
  }

  void _phoneNumberValidator(bool hasError) {
    _phoneNumberError = hasError;
  }

  void _passwordValidator(bool hasError) {
    _passwordError = hasError;
  }

  void _selectSection(int index) {
    if (mounted) {
      setState(() {
        _activeSection = index;
      });
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

  void _navigate(Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  void _navigateToForgotpasswordScreen() async {
    _navigate(
      const ForgotPasswordScreen(),
    );
  }

  bool _validate() {
    bool isValid = false;

    if (_activeSection == 0) {
      _phoneKey.currentState?.validate();

      _passwordKey.currentState?.validate();

      isValid = !_phoneNumberError && !_passwordError;
      if (isValid) {
        _passwordKey.currentState?.save();

        _phoneKey.currentState?.save();
      }
    } else if (_activeSection == 1) {
      _emailKey.currentState?.validate() ?? false;

      _passwordKey.currentState?.validate();

      isValid = !_emailError && !_passwordError;
      if (isValid) {
        _passwordKey.currentState?.save();

        _emailKey.currentState?.save();
      }
    }

    String authState =
        _activeSection == 1 ? AuthStatus.email.value : AuthStatus.phone.value;

    ref.read(authProvider.notifier).updateField("authType", authState);

    return isValid;
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

  Future<void> _submit() async {
    if (!_validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(authProvider.notifier).signIn(
            userName: _userName.toString(),
            password: _password.toString(),
          );

      ref.read(authProvider.notifier).updateField("isGuest", false);

      if (mounted) {
        _navigate(const TabsScreen());
      }
    } on CustomHttpException catch (error) {
      final errorMessage = error.toString();
      String message =
          "It seems you started onboarding, welcome back, ...continue your signup process";

      if (errorMessage == AuthStatus.hasNotConfirmedEmail.value ||
          errorMessage == AuthStatus.hasNotConfirmedPhoneNumber.value) {
        final authData = ref.watch(authProvider);

        String title = authData.authType == AuthStatus.phone.value
            ? "Authenticate..."
            : "Verify email address";

        String subTitle = authData.authType == AuthStatus.phone.value
            ? "A one-time passcode has been sent to your phone number ending with ${_valdate.getLastFourCharacters(authData.phoneNumber.toString())}"
            : "A verification code has been sent to your email address ${_valdate.maskEmail(authData.email.toString())}";

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
      title: "Log in to continue",
      showSubtitle: false,
      body: Column(
        children: [
          TabSwitcher(activeSection: _activeSection, onTap: _selectSection),
          IndexedStack(
            index: _activeSection,
            children: _sections,
          ),
          BottomSection(
            navigateToForgotpasswordScreen: _navigateToForgotpasswordScreen,
            normalAuthIsLoading: _isLoading,
            passwordKey: _passwordKey,
            validator: _passwordValidator,
            onSave: _passwordOnSaveHandler,
            continueBtn: _submit,
            authState: AuthStatus.signin.value,
            activeSection: _activeSection,
          ),
        ],
      ),
    );
  }
}
