import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: _customColor.customEFEFEF)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 134,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.88),
              boxShadow: [
                BoxShadow(
                  color: _customColor.customRgba4,
                  offset: const Offset(0, 10),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 16, right: 32, left: 16),
                      decoration:
                          BoxDecoration(color: _customColor.customF9E8CC),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tever wallet",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _customColor.customB0B0B0,
                                    fontFamily: "Anybody"),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        "₦ ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: _customColor.custom888888,
                                        ),
                                      )),
                                  Text(
                                    "100,000.00 ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: _customColor.custom242424,
                                    ),
                                  ),
                                  const SizedBox(width: 1),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Image.asset(
                                        "assets/icon/drop_down.png",
                                        height: 16,
                                        width: 16,
                                      )),
                                ],
                              )
                            ],
                          ),
                          Image.asset(
                            "assets/logo/tever_gray_logo.png",
                            height: 28,
                            width: 28,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    color: Colors.white,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Wallet ID: ",
                          ),
                          TextSpan(
                            text: "profile_username",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: theme.primaryColor,
                            ),
                          ),
                          const WidgetSpan(
                              child: SizedBox(
                            width: 8,
                          )),
                          WidgetSpan(
                            child: Image.asset(
                              "assets/icon/copy_grey.png",
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ],
                        style: TextStyle(
                          fontSize: 12,
                          color: _customColor.custom242424,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Default currency",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 3),
          Text(
            "Set the default currency for your wallet transactions",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: _customColor.custom6D6D6D),
          ),
          const SizedBox(height: 16),
          Text(
            "Currency",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 9),
          TextFormField(
            style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 14,
            ),
            initialValue: "Naira (NGN)",
            decoration: InputDecoration(
              hintText: "Enter currency",
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              suffixIconConstraints:
                  const BoxConstraints(maxHeight: 150, maxWidth: 150),
              suffixIcon: Container(
                margin: const EdgeInsets.only(right: 16),
                child: Image.asset(
                  "assets/icon/drop_down.png",
                  height: 16,
                  width: 16,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 1),
              ),
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom888888,
              ),
            ),
            onChanged: (value) async {},
          ),
        ],
      ),
    );
  }
}
