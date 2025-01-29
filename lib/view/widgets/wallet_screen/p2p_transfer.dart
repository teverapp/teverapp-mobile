import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_screen/declined_request.dart';
import 'package:tever/view/widgets/wallet_screen/intiated_fund_transfer.dart';
import 'package:tever/view/widgets/wallet_screen/p2p_session_expired.dart';
import 'package:tever/view/widgets/wallet_screen/p2p_waiting.dart';
import 'package:tever/view/widgets/wallet_screen/request_accepted.dart';

class P2pTransfer extends StatelessWidget {
  final VoidCallback cardAddedHandler;
  const P2pTransfer({super.key, required this.cardAddedHandler});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: _customColor.customEFEFEF)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // P2pWaiting(),
          // P2pSessionExpired(),
          //RequestAccepted(),
          //  DeclinedRequest(),
          //IntiatedFundTransfer(),
          Text(
            "Provide the wallet ID of the Tever user you are requesting funds from",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 10),
          Text(
            "Wallet ID",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 9),
          TextFormField(
            style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: "Enter wallet ID",
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 1),
              ),
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424,
              ),
            ),
            onChanged: (value) async {},
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: _customColor.customEDFCF6,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account name:",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _customColor.custom242424),
                      ),
                      Text(
                        "John Doe:",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _customColor.custom242424),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/icon/check_mark_green.png",
                    height: 24,
                    width: 24,
                  )
                ]),
          ),
          const SizedBox(height: 16),
          Text(
            "Amount",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 9),
          TextFormField(
            style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 14,
            ),
            initialValue: "₦7,000",
            decoration: InputDecoration(
              hintText: "Enter amount",
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 1),
              ),
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424,
              ),
            ),
            onChanged: (value) async {},
          ),
          const SizedBox(height: 16),
          Text(
            "Narration (Optional)",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 9),
          TextFormField(
            style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: "Enter a narration for this transfer",
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 1),
              ),
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424,
              ),
            ),
            onChanged: (value) async {},
          ),
          const SizedBox(height: 16),
          Container(
            height: 40,
            width: 129,
            decoration: BoxDecoration(
                color: _customColor.customEFEFEF,
                borderRadius: BorderRadius.circular(100)),
            child: TextButton(
              style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
              onPressed: () {
                // setState(() {
                //   _startAddingCardDetails = true;
                //   _showAddCardButton = false;
                // });
              },
              child: Text(
                "Request funds",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom6D6D6D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
