import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_screen/receipt_card.dart';

class TransactionDetailsBottomSheet extends StatelessWidget {
  const TransactionDetailsBottomSheet({
    super.key,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 610,
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
                  "Transaction details",
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
              label: "Email",
              value: "johndoe@email.com",
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Order ID",
              value: "1234567890",
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Product/ service name",
              value: "Fumigation service",
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Transaction type",
              value: "Transaction type",
            ),
            const SizedBox(height: 8),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: _customColor.customEFEFEF,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment method",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom242424),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Online payment",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _customColor.custom242424),
                      ),
                      const SizedBox(height: 5),
                      Image.asset(
                        "assets/image/paystack.png",
                        width: 67.35,
                        height: 12,
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Transaction Reference number",
              value: "1234567890",
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Transaction ID",
              value: "1234567890",
            ),
            const SizedBox(height: 8),
            const ReceiptCard(
              label: "Amount",
              value: "₦7,000",
              boldValue: true,
            ),
            const SizedBox(height: 8),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: _customColor.customEFEFEF,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom242424),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _customColor.customD2F9E7,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      "Successful",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _customColor.custom08745B),
                    ),
                  )
                ],
              ),
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
                          "Download details",
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
