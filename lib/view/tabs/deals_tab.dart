import 'package:flutter/material.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/tabs/home_tab/search.dart';
import 'package:tever/view/widgets/tabs/deals_tab/trending.dart';
import 'package:tever/view/widgets/tabs/deals_tab/filter.dart';
import 'package:tever/view/widgets/tabs/deals_tab/top_tab.dart';
import 'package:tever/view/widgets/tabs/home_tab/get_started_checklist.dart';
import 'package:tever/view/widgets/tabs/home_tab/quick_action.dart';
import 'package:tever/view/widgets/tabs/home_tab/trending_on_trevor.dart';
import 'package:tever/view/widgets/tabs/home_tab/welcome.dart';

class DealsTab extends StatefulWidget {
  const DealsTab({super.key});

  @override
  State<DealsTab> createState() => _DealsTabState();
}

class _DealsTabState extends State<DealsTab> {
  final CustomColors _customColor = const CustomColors();

  bool applyFilter = false;

  void _toggleShowFilter() {
    setState(() {
      applyFilter = !applyFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
        child: Stack(children: [
          Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TopTab(),
                  Search(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _customColor.custom242424,
                        ),
                      ),
                      GestureDetector(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "View all",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: theme.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              "assets/icon/arrow_right_orange.png",
                              height: 16,
                              width: 16,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
              const Expanded(child: Trending())
            ],
          ),
          if (applyFilter) Filter(toggleShowFilter: _toggleShowFilter)
        ]));
  }
}
