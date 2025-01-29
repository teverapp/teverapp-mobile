import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_screen/scan_to_pay_bottom_sheet.dart';
import 'package:tever/view/widgets/wallet_screen/wallet_top_up_bottom_sheet.dart';
import 'package:tever/view/widgets/wallet_screen/withdrwal_bottom_sheet.dart';

class QuickActions extends StatefulWidget {
  const QuickActions({super.key});

  @override
  State<QuickActions> createState() => _QuickActionsState();
}

class _QuickActionsState extends State<QuickActions> {
  late Color color1;
  late Color color2;
  late Color color3;
  late Color color4;
  late Color color5;

  final CustomColors _customColor = const CustomColors();

  late List<Map<String, dynamic>> _quickAction;

  void _walletTopUpBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const WalletTopUpBottomSheet();
      },
    );
  }

  void _withdrawalBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const WithdrawalBottomSheet();
      },
    );
  }

  void _scanToPayBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const ScanToPayBottomSheet();
      },
    );
  }

  @override
  void initState() {
    super.initState();

    color1 = _customColor.customFDF7ED;
    color2 = _customColor.customF3F7FC;
    color3 = _customColor.customEDFCF6;
    color4 = _customColor.customF6F3FF;
    color5 = _customColor.customF6F6F6;

    _quickAction = [
      {
        "icon": "add_orange.png",
        "label": "Top up",
        "color": color1,
        "callback": _walletTopUpBottomSheet
      },
      {
        "icon": "card_send.png",
        "label": "Send",
        "color": color2,
        "callback": () {}
      },
      {
        "icon": "card_recieve.png",
        "label": "Receive",
        "color": color3,
        "callback": () {}
      },
      {
        "icon": "scan.png",
        "label": "Scan to pay",
        "color": color4,
        "callback": _scanToPayBottomSheet
      },
      {
        "icon": "arrow_right_down.png",
        "label": "Withdraw",
        "color": color5,
        "callback": _withdrawalBottomSheet
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick actions",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424,
            ),
          ),
          const SizedBox(height: 25),
          Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 8,
            spacing: 8,
            children: _quickAction.map((action) {
              return GestureDetector(
                onTap: action["callback"],
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: action['color'] as Color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/icon/${action['icon']}",
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        action['label'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _customColor.custom242424,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
