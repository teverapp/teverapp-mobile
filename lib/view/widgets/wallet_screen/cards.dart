import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/wallet_details_screen.dart';

class Cards extends StatefulWidget {
  final Function activeCardHandler;
  const Cards({super.key, required this.activeCardHandler});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  final CustomColors _customColor = const CustomColors();

  final ScrollController _scrollController = ScrollController();

  final List<GlobalKey> _cardKeys = [];

  late List<Map<String, dynamic>> _cards;

  int _activeCardIndex = 0;

  void _checkVisibility() {
    for (int i = 0; i < _cardKeys.length; i++) {
      final key = _cardKeys[i];
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        // Position in global coordinates
        final position = renderBox.localToGlobal(Offset.zero);
        // final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // Check if the card is within the screen bounds
        if (position.dx >= 0 &&
            position.dx + renderBox.size.width <= screenWidth) {
          print("Card $i is visible");
          setState(() {
            _activeCardIndex = i;
          });
          widget.activeCardHandler(i);
        }
      }
    }
  }

  Widget _buildCard(
      {required int index,
      required String title,
      required String amount,
      required Color bgColor,
      required ThemeData theme,
      required Color activeBorderColor}) {
    return Container(
      key: _cardKeys[index],
      height: 144,
      width: 300,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _customColor.customRgba4,
            offset: const Offset(0, 10),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          width: 1,
          color: _activeCardIndex == index
              ? activeBorderColor
              : Colors.transparent,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                decoration: BoxDecoration(
                  color: bgColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _customColor.customB0B0B0,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Text(
                              "₦ ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: _customColor.custom888888,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "$amount ",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: _customColor.custom242424,
                              ),
                            ),
                            const SizedBox(width: 2),
                            if (title == _cards[1]["title"])
                              Container(
                                height: 20,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: _customColor.customF5FD99),
                                child: Row(
                                  children: [
                                    Image.asset("assets/icon/emoji_smile.png",
                                        height: 12, width: 12),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "Odogwu",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: _customColor.custom57660E),
                                    )
                                  ],
                                ),
                              ),
                            if (title != _cards[1]["title"])
                              Image.asset(
                                "assets/icon/drop_down.png",
                                height: 16,
                                width: 16,
                              ),
                          ],
                        )
                      ],
                    ),
                    Image.asset(
                      "assets/logo/tever_gray_logo.png",
                      height: 24,
                      width: 24,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
                onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const WalletDetailsScreen()),
                    ),
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "View reward levels",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: _customColor.custom242424,
                        ),
                      ),
                      Image.asset(
                        "assets/icon/arrow_right_darker.png",
                        height: 12,
                        width: 12,
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _cards = [
      {
        "title": "Tever wallet",
        "amount": "100,000.00",
        "bgColor": _customColor.customF9E8CC,
        "activeBorderColor": _customColor.customE1781F
      },
      {
        "title": "Tever reward",
        "amount": "10,000",
        "bgColor": _customColor.customD2F9E7,
        "activeBorderColor": _customColor.custom15B488
      },
    ];

    // Initialize a GlobalKey for each card
    _cardKeys.addAll(List.generate(_cards.length, (_) => GlobalKey()));

    // Listen for scroll events
    _scrollController.addListener(_checkVisibility);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24, top: 8, left: 16),
        child: Row(
          children: _cards
              .asMap()
              .entries
              .map(
                (entry) => _buildCard(
                    index: entry.key,
                    amount: entry.value["amount"],
                    bgColor: entry.value["bgColor"],
                    title: entry.value["title"],
                    theme: theme,
                    activeBorderColor: entry.value["activeBorderColor"]),
              )
              .toList(),
        ),
      ),
    );
  }
}
