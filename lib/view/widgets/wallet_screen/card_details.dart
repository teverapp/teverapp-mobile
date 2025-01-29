import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/wallet_card_form.dart';

class CardDetails extends StatelessWidget {
  final VoidCallback cardAddedHandler;
  const CardDetails({super.key, required this.cardAddedHandler});

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
            const WalletCardForm(),
            const SizedBox(height: 16),
            Container(
              height: 40,
              width: 93,
              decoration: BoxDecoration(
                  color: _customColor.customF9E8CC,
                  borderRadius: BorderRadius.circular(100)),
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 0)),
                onPressed: cardAddedHandler,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/icon/radio_active_circular.png",
                          height: 20, width: 20),
                      const SizedBox(width: 8),
                      Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _customColor.custom242424),
                      ),
                    ]),
              ),
            ),
          ],
        ));
  }
}
