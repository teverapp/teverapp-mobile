import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/current_location.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/check_and_confirm.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_form.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/pre_live_check.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/set_terms.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/about.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/action_buttons.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/ads.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/comment_and_rating.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/more_hot_deals.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/product_images.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/source.dart';
import 'package:tever/view/widgets/wallet_details_card/card_details.dart';
import 'package:tever/view/widgets/wallet_details_card/linked_cards.dart';
import 'package:tever/view/widgets/wallet_details_card/security.dart';
import 'package:tever/view/widgets/wallet_screen/cards.dart';
import 'package:tever/view/widgets/wallet_screen/my_transactions_section.dart';
import 'package:tever/view/widgets/wallet_screen/quick_actions.dart';
import 'package:tever/view/widgets/wallet_screen/recent_transactions.dart';
import 'package:tever/view/widgets/wallet_screen/recent_activities.dart';
import 'package:tever/view/widgets/wallet_screen/referral_program_section.dart';
import 'package:tever/view/widgets/wallet_screen/wallet_activation_checklist.dart';

class WalletDetailsScreen extends StatefulWidget {
  const WalletDetailsScreen({super.key});

  @override
  State<WalletDetailsScreen> createState() => _WalletDetailsScreenState();
}

class _WalletDetailsScreenState extends State<WalletDetailsScreen> {
  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  height: 25,
                  width: 25,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: IconButton.styleFrom(padding: EdgeInsets.zero),
                    icon: Image.asset(
                      "assets/icon/arrow_left.png",
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Wallet details",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom242424,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CardDetails(),
                  SizedBox(
                    height: 20,
                  ),
                  Security(),
                  SizedBox(
                    height: 20,
                  ),
                  LinkedCards()
                ],
              )),
        ),
      ),
    );
  }
}
