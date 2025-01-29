import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_screen/make_payment.dart';
import 'package:tever/view/widgets/wallet_screen/scan_to_pay_card.dart';
import 'package:tever/view/widgets/wallet_screen/transaction.dart';

class ScanToPayBottomSheet extends StatelessWidget {
  const ScanToPayBottomSheet({super.key});

  void _popBottomSheet(BuildContext context) {
    Navigator.of(context).pop();
  }

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
          const Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScanToPayCard(),
                  // MakePayment(),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
