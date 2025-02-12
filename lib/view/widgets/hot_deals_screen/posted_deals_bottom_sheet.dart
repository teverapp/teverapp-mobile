import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/helpers/world_countries.dart';
import 'package:tever/model/country.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/screens/tabs_screen.dart';
import 'package:tever/view/screens/waiting_screen.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';
import 'package:tever/view/widgets/otp_screen/otp_inputs.dart';
import 'package:tever/view/widgets/otp_screen/resend_otp.dart';

class PostedDealsBottomSheet extends ConsumerStatefulWidget {
  final String id;
  const PostedDealsBottomSheet({super.key, required this.id});

  @override
  ConsumerState<PostedDealsBottomSheet> createState() =>
      _PostedDealsBottomSheetState();
}

class _PostedDealsBottomSheetState
    extends ConsumerState<PostedDealsBottomSheet> {
  final CustomColors _customColor = const CustomColors();

  Widget _buildCard({
    required String icon,
    required Color iconColor,
    required Color iconCardColor,
    required String title,
    required String content,
  }) {
    return Container(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 24,
                width: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconCardColor,
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    iconColor,
                    BlendMode.srcATop,
                  ),
                  child: Image.asset(
                    "assets/icon/$icon",
                    height: 16,
                    width: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: _customColor.custom242424,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                content,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom242424,
                ),
              ),
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _customColor.customB0B0B0,
                  BlendMode.srcATop,
                ),
                child: Image.asset(
                  "assets/icon/arrow_right_dark_thick.png",
                  height: 19,
                  width: 19,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final mediaQuery = MediaQuery.of(context).size;

    final double height = mediaQuery.height * 0.9;

    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _customColor.custom6D6D6D,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        "assets/image/get_started_image.png",
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Exclusive Luxe Clutch Bag Collection - 30% discount for a limited time only!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "₦100  ",
                              style: TextStyle(
                                fontSize: 16,
                                color: _customColor.custom242424,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "₦100",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: _customColor.custom888888,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: _customColor.custom888888,
                                decorationThickness: 2.0,
                              ),

                              //
                            ),
                          ],
                          style: TextStyle(
                              color: _customColor.custom4F4F4F,
                              fontSize: 14,
                              height: 1.3,
                              fontFamily: 'Inter')),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                          color: _customColor.customE7F84A,
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        "30% off",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: _customColor.custom242424),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _buildCard(
                      icon: "orders_active.png",
                      iconCardColor: _customColor.customFDF7ED,
                      iconColor: theme.primaryColor,
                      title: "Total interests/ orders",
                      content: "0"),
                  const SizedBox(height: 8),
                  _buildCard(
                      icon: "message.png",
                      iconCardColor: _customColor.customF3F7FC,
                      iconColor: theme.colorScheme.primary,
                      title: "Total messages",
                      content: "0"),
                  const SizedBox(height: 8),
                  _buildCard(
                      icon: "star_empty.png",
                      iconCardColor: _customColor.customF6F3FF,
                      iconColor: _customColor.custom965CF6,
                      title: "Total reviews",
                      content: "0"),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 8,
                      spacing: 8,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/icon/radio_circular_inactive.png",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Promote deal as Tever's top pick",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: _customColor.custom242424,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Container(
                          height: 25,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                              color: _customColor.customE5F0F9,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  width: 1, color: _customColor.customEFEFEF)),
                          child: TextButton(
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            onPressed: () {},
                            child: Text(
                              "Upgrade to premium",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: theme.colorScheme.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
