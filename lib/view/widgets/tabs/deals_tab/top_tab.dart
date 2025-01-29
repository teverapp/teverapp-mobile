import 'package:flutter/material.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/current_location.dart';

class TopTab extends StatefulWidget {
  const TopTab({super.key});

  @override
  State<TopTab> createState() => _TopTabState();
}

class _TopTabState extends State<TopTab> {
  final CustomColors _customColor = const CustomColors();

  String _selectedSection = DealsTabStatus.hotDeals.value;

  final List<String> _sections = [
    DealsTabStatus.hotDeals.value,
    DealsTabStatus.services.value,
    DealsTabStatus.items.value,
    DealsTabStatus.events.value,
    DealsTabStatus.spaces.value
  ];

  final CustomColors _customColors = const CustomColors();

  void _selectSection(String key) {
    setState(() {
      _selectedSection = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Deals",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Anybody",
                  fontWeight: FontWeight.w600,
                  color: _customColor.custom242424),
            ),
            const CurrentLocation()
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _sections
              .map(
                (value) => Expanded(
                  child: GestureDetector(
                    onTap: () => _selectSection(value),
                    child: Container(
                      height: 26,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      margin: EdgeInsets.only(
                        right: value != DealsTabStatus.spaces.value ? 8 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: value == _selectedSection
                            ? _customColors.customF3D094
                            : _customColors.customEFEFEF,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        value,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: value == _selectedSection
                              ? _customColors.custom242424
                              : _customColors.custom888888,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16)
      ],
    );
  }
}
