import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_details_card/switch_button.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  final CustomColors _customColor = const CustomColors();

  bool _isEmailAutentication = false;

  bool _isPhoneAutentication = false;

  void _tooglePhoneAuthHandler() {
    setState(() {
      _isPhoneAutentication = !_isPhoneAutentication;
    });
  }

  void _toogleEmailAuthHandler() {
    setState(() {
      _isEmailAutentication = !_isEmailAutentication;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: _customColor.customEFEFEF)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Security",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset(
                "assets/icon/shield_tick.png",
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Learn more about your wallet security",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom15B488),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: _customColor.customEFEFEF,
            thickness: 1,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "OTP for wallet transactions",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Text(
            "Secure your wallet with an extra layer of protection",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: _customColor.custom6D6D6D,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: _customColor.customEFEFEF),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email authentication",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: _customColor.custom242424,
                      ),
                    ),
                    SwitchButton(
                        isOn: _isEmailAutentication,
                        toggleHandler: _toogleEmailAuthHandler)
                  ],
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              "By enabling email authentication, a one-time passcode will be sent to the email address associated with your Tever account, ",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "jo*****@gmail.com ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: theme.primaryColor),
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap =
                          //       () => _resendOtpLink(email.toString())
                          //
                        ),
                        const TextSpan(
                          text: "on your next transaction.",
                          style: TextStyle(),
                        ),
                      ],
                      style: TextStyle(
                          color: _customColor.custom6D6D6D,
                          fontSize: 14,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter')),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: _customColor.customEFEFEF),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone authentication",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: _customColor.custom242424,
                  ),
                ),
                SwitchButton(
                    isOn: _isPhoneAutentication,
                    toggleHandler: _tooglePhoneAuthHandler)
              ],
            ),
          )
        ],
      ),
    );
  }
}
