import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/wallet_card_form.dart';
import 'package:tever/view/widgets/wallet_screen/card_added.dart';

import 'package:tever/view/widgets/wallet_screen/transaction.dart';

class LinkACardBottomSheet extends StatelessWidget {
  final VoidCallback submitFormHandler;
  const LinkACardBottomSheet({super.key, required this.submitFormHandler});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final height = mediaQuery.height * 0.92;

    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: height),
        padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 5,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: _customColor.custom6D6D6D,
              ),
            ),
          ),
          const SizedBox(height: 26),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Link a debit/ credit card",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424,
                      fontFamily: "Anybody"),
                ),
                const SizedBox(height: 5),
                Text(
                  "Add a debit/ credit card to your Tever wallet",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _customColor.custom6D6D6D),
                ),
                const SizedBox(height: 37),
                const WalletCardForm(),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                  color: _customColor.custom242424, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              "Edit details",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: _customColor.custom242424,
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            submitFormHandler();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20)
              ],
            ),
          )
        ]),
      ),
    );
  }
}
