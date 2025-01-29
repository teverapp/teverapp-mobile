import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_screen/receipt_card.dart';

class ReceiptBottomSheet extends StatelessWidget {
  const ReceiptBottomSheet({
    super.key,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 520,
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
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/logo/logo_light_gray.png",
                  width: 111,
                  height: 24,
                ),
                Text(
                  "Receipt",
                  style: TextStyle(
                      fontSize: 18,
                      color: _customColor.custom242424,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Anybody"),
                )
              ],
            ),
            const SizedBox(height: 24),
            const ReceiptCard(
              label: "Date",
              value: "30 Oct, 2024; 12:44PM",
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Transaction ID",
              value: "1234567890",
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Description",
              value: "P2P Transfer",
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Recipient's username",
              value: "johndoe1234567890",
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Account name",
              value: "John Doe",
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Amount",
              value: "₦7,000",
              boldValue: true,
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Narration",
              value: "For DD",
              boldValue: true,
            ),
            const SizedBox(height: 24),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _customColor.customF9E8CC,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {},
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icon/document_download.png",
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Download receipt",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _customColor.custom242424),
                        )
                      ])),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
