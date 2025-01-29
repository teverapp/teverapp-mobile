import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class CartItems extends StatefulWidget {
  const CartItems({super.key});

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  final CustomColors _customColor = const CustomColors();

  List<String> _cartPlaceHolder = ["", ""];

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: ListView.builder(
            itemCount: _cartPlaceHolder.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(top: index == 0 ? 24 : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft:
                        index == 0 ? const Radius.circular(12) : Radius.zero,
                    topRight:
                        index == 0 ? const Radius.circular(12) : Radius.zero,
                    bottomLeft: _cartPlaceHolder.length - 1 == index
                        ? const Radius.circular(12)
                        : Radius.zero,
                    bottomRight: _cartPlaceHolder.length - 1 == index
                        ? const Radius.circular(12)
                        : Radius.zero,
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            // Toggle accordion: If the same index is clicked, reset _selectedIndex
                            _selectedIndex =
                                _selectedIndex == index ? -1 : index;
                          });
                        },
                        child: Container(
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: _customColor.customEFEFEF,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icon/radio_inactive.png",
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Item Purchase".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _customColor.custom965CF6,
                                    ),
                                  ),
                                ],
                              ),
                              AnimatedRotation(
                                turns: _selectedIndex == index ? 0.5 : 0,
                                duration: const Duration(milliseconds: 300),
                                child: Image.asset(
                                  "assets/icon/drop_down.png",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_selectedIndex == index) const SizedBox(height: 16),
                      if (_selectedIndex == index)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: _customColor.customEFEFEF,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icon/radio_inactive.png",
                                        height: 16,
                                        width: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Luxe Essentials",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    child: Image.asset(
                                      "assets/icon/trash.png",
                                      height: 16,
                                      width: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 61.45,
                                    width: 80,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.asset(
                                        "assets/image/trending_image_placeholder.png",
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Exclusive Luxe Clutch Bag Collection - 30% discount for a limited time only!",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: _customColor.custom242424,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "₦7,000 ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color:
                                                      _customColor.custom242424,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "₦10,000",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color:
                                                      _customColor.custom888888,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor:
                                                      _customColor.custom888888,
                                                  decorationThickness: 2.0,
                                                ),
                                              ),
                                              const WidgetSpan(
                                                child: SizedBox(
                                                  width: 8,
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: _customColor
                                                        .customE7F84A,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 4,
                                                      horizontal: 8,
                                                    ),
                                                    child: Text(
                                                      "30% off",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: _customColor
                                                            .custom242424,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            style: const TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Text(
                                              "Quantity",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: _customColor
                                                      .custom6D6D6D),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              height: 24,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: _customColor
                                                          .customEFEFEF)),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    child: Image.asset(
                                                      "assets/icon/minus.png",
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "1",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: _customColor
                                                          .custom242424,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  GestureDetector(
                                                      child: Image.asset(
                                                    "assets/icon/add_green.png",
                                                    height: 16,
                                                    width: 16,
                                                  )),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
