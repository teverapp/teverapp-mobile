import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_screen/card_added.dart';

import 'package:tever/view/widgets/wallet_screen/transaction.dart';

class WalletTopUpBottomSheet extends StatelessWidget {
  const WalletTopUpBottomSheet({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final height = mediaQuery.height * 0.92;

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
                  "Top up your Tever Wallet",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424,
                      fontFamily: "Anybody"),
                ),
                const SizedBox(height: 10),
                Text(
                  "Enter the amount to top up your wallet with and choose your preferred payment method",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom5D5D5D),
                ),
                const Flexible(
                  child: Transaction(),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
