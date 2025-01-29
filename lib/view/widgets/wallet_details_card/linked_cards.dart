import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_details_card/switch_button.dart';
import 'package:tever/view/widgets/wallet_screen/link_a_card_bottom_sheet.dart';

class LinkedCards extends StatefulWidget {
  const LinkedCards({super.key});

  @override
  State<LinkedCards> createState() => _LinkedCardsState();
}

class _LinkedCardsState extends State<LinkedCards> {
  final CustomColors _customColor = const CustomColors();

  bool _hasAddedACard = false;

  void _linkACardBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return LinkACardBottomSheet(submitFormHandler: _submitFormHandler);
      },
    );
  }

  void _submitFormHandler() {
    if (!_hasAddedACard) {
      setState(() {
        _hasAddedACard = true;
      });
    }
  }

  Widget _buildCard() {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: _customColor.customEFEFEF))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icon/radio_inactive_circular.png",
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      "assets/icon/master_card.png",
                      height: 16.07,
                      width: 26,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    // radio_circular_inactive.png
                    Text(
                      "*** 3232",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom242424,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/icon/edit_blue.png",
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      "assets/icon/close-circle_red.png",
                      height: 16,
                      width: 16,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 25,
              width: 125,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: _customColor.customF5FD99,
                  borderRadius: BorderRadius.circular(100)),
              child: Text(
                "Card set as default",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom57660E,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ));
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
            "Linked cards",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary),
          ),
          const SizedBox(
            height: 20,
          ),
          if (_hasAddedACard) _buildCard(),
          Container(
            height: 40,
            decoration: BoxDecoration(
                color: _customColor.customF9E8CC,
                borderRadius: BorderRadius.circular(100)),
            child: TextButton(
              style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
              onPressed: _linkACardBottomSheet,
              child: Text(
                _hasAddedACard
                    ? "Link another card"
                    : "Link a debit/ credit card",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom242424),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
