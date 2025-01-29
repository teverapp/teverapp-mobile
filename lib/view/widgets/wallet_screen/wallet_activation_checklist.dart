import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class WalletActivationChecklist extends StatelessWidget {
  const WalletActivationChecklist({super.key});

  final CustomColors _customColor = const CustomColors();

  Widget _buildCard(
      {required String icon,
      required String title,
      required String subTitle,
      required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: _customColor.customEFEFEF),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              "assets/icon/$icon",
              height: 20,
              width: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: _customColor.custom263003,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  subTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _customColor.custom6D6D6D,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Wallet activation checklist",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424,
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
              color: _customColor.customFBFEC9,
              icon: "verify.png",
              title: "Complete KYC",
              subTitle: "Verify your identity to enable wallet features."),
          const SizedBox(height: 8),
          _buildCard(
              color: _customColor.customD2F9E7,
              icon: "shield_security.png",
              title: "Enable OTP for wallet transactions",
              subTitle: "Secure your wallet with an extra layer of protection")
        ],
      ),
    );
  }
}
