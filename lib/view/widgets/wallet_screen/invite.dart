import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class Invite extends StatelessWidget {
  const Invite({super.key});

  final CustomColors _customColor = const CustomColors();

  Widget _buildSocialCard({required String icon}) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.only(right: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: _customColor.customE5F0F9,
          borderRadius: BorderRadius.circular(12)),
      child: Image.asset(
        "assets/icon/$icon",
        height: 24,
        width: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: _customColor.customEFEFEF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Invite via email or phone number",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 16),
          Text(
            "Email or phone number",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 8),
          Container(
            height: 48,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: _customColor.customEFEFEF,
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      color: _customColor.custom242424,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter email or phone number",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.only(left: 16, right: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom4F4F4F,
                      ),
                    ),
                    onChanged: (value) async {},
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                width: 104,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                      ),
                      padding: EdgeInsets.zero),
                  onPressed: () {},
                  child: const Text(
                    "Send invite",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 30),
          Text(
            "Copy and share your unique link",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 16),
          Text(
            "Referral link",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 8),
          Container(
            height: 48,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: _customColor.customEFEFEF,
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      color: _customColor.custom242424,
                      fontSize: 14,
                    ),
                    initialValue: "https://app.tever.io/invite/123uodef238",
                    decoration: InputDecoration(
                      hintText: "Referral link",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.only(left: 16, right: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom4F4F4F,
                      ),
                    ),
                    onChanged: (value) async {},
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                width: 48,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                      ),
                      padding: EdgeInsets.zero),
                  onPressed: () {},
                  child: Image.asset(
                    "assets/icon/copy.png",
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 32),
          Text(
            "Share on Social",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _buildSocialCard(icon: "facebook.png"),
              _buildSocialCard(icon: "twitter.png"),
              _buildSocialCard(icon: "instagram.png"),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildSocialCard(icon: "twitter.png"),
              _buildSocialCard(icon: "snapchat.png"),
              _buildSocialCard(icon: "threads.png"),
              _buildSocialCard(icon: "whatsapp.png"),
            ],
          )
        ],
      ),
    );
  }
}
