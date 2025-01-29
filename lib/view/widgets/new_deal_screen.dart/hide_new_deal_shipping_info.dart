import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';

class HideNewDealShippingInfo extends ConsumerWidget {
  const HideNewDealShippingInfo({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final newDealData = ref.watch(newDealDataProvider);

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _customColor.customE5F0F9,
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/icon/info_circle_thin.png",
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Text(
            "Shipping is not required for ${newDealData.type!.name.toLowerCase()}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: theme.colorScheme.primary,
            ),
          ))
        ],
      ),
    );
  }
}
