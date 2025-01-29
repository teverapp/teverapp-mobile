import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/tabs/deals_tab/trending_items.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TrendingItems(),
          const SizedBox(height: 18),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: _customColor.customFEFFE6,
            ),
            height: 129,
            child: Text(
              "Ads",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _customColor.customB0B0B0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
