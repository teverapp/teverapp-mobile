import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/qr_code.dart';

class BusinessProfileCreatedSuccessfullBottomSheet extends StatelessWidget {
  const BusinessProfileCreatedSuccessfullBottomSheet({
    super.key,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 330,
        padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            const SizedBox(height: 30),
            Text(
              "Your business profile has been created successfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _customColor.custom242424,
                  fontFamily: "Anybody"),
            ),
            const SizedBox(height: 14),
            Text(
              "You can now copy, share or print out your QR code for your physical store or outlet",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom6D6D6D,
              ),
            ),
            const SizedBox(height: 24),
            const QrCode(),
          ],
        ),
      ),
    );
  }
}
