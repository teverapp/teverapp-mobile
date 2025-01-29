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
import 'package:tever/view/widgets/wallet_screen/invite.dart';
import 'package:tever/view/widgets/wallet_screen/leader_board.dart';
import 'package:tever/view/widgets/wallet_screen/points_earned.dart';
import 'package:tever/view/widgets/wallet_screen/quick_actions.dart';
import 'package:tever/view/widgets/wallet_screen/recent_transactions.dart';
import 'package:tever/view/widgets/wallet_screen/recent_activities.dart';
import 'package:tever/view/widgets/wallet_screen/wallet_activation_checklist.dart';

class ReferralProgramSection extends StatefulWidget {
  const ReferralProgramSection({super.key});

  @override
  State<ReferralProgramSection> createState() => _ReferralProgramSectionState();
}

class _ReferralProgramSectionState extends State<ReferralProgramSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const LeaderBoard(),
        const SizedBox(height: 20),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: const Column(
            children: [
              PointsEarned(),
              SizedBox(height: 24),
              Invite(),
            ],
          ),
        )
      ],
    );
  }
}
