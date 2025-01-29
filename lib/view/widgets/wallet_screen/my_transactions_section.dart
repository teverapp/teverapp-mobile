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
import 'package:tever/view/widgets/wallet_screen/cards.dart';
import 'package:tever/view/widgets/wallet_screen/quick_actions.dart';
import 'package:tever/view/widgets/wallet_screen/recent_transactions.dart';
import 'package:tever/view/widgets/wallet_screen/recent_activities.dart';
import 'package:tever/view/widgets/wallet_screen/wallet_activation_checklist.dart';

class MyTransactionsSection extends StatefulWidget {
  const MyTransactionsSection({super.key});

  @override
  State<MyTransactionsSection> createState() => _MyTransactionsSectionState();
}

class _MyTransactionsSectionState extends State<MyTransactionsSection> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        QuickActions(),
        WalletActivationChecklist(),
        RecentTransactions(),
        SizedBox(height: 24),
        RecentActivities(),
        SizedBox(height: 24),
      ],
    );
  }
}
