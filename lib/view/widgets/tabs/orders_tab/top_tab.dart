import 'package:flutter/material.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/extensions/orders_tab.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/current_location.dart';

class TopTab extends StatefulWidget {
  const TopTab({super.key});

  @override
  State<TopTab> createState() => _TopTabState();
}

class _TopTabState extends State<TopTab> {
  final CustomColors _customColor = const CustomColors();

  String _selectedSection = OrdersTabStatus.myCart.value;

  final List<String> _sections = [
    OrdersTabStatus.myCart.value,
    OrdersTabStatus.ongoing.value,
    OrdersTabStatus.complete.value,
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
              "Orders",
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: _sections
              .map(
                (value) => GestureDetector(
                  onTap: () => _selectSection(value),
                  child: Container(
                    height: 26,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.only(
                      right: value != OrdersTabStatus.complete.value ? 20 : 0,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: value == _selectedSection
                                  ? theme.primaryColor
                                  : Colors.transparent)),
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
              )
              .toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/icon/minus_square.png",
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  "Unselect",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom888888),
                )
              ],
            ),
            Row(
              children: [
                Image.asset(
                  "assets/icon/trash.png",
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  "Delete selected items",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.error),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
