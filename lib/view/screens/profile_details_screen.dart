import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

import 'package:tever/view/widgets/profile_details_screen/business_profile.dart';
import 'package:tever/view/widgets/profile_details_screen/personal_info_form.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final CustomColors _customColor = const CustomColors();

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  height: 25,
                  width: 25,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: IconButton.styleFrom(padding: EdgeInsets.zero),
                    icon: Image.asset(
                      "assets/icon/arrow_left.png",
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Profile details",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: _customColor.custom242424,
                      fontFamily: "Anybody"),
                )
              ],
            ),
          ))),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                //Personal Information
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = _selectedIndex == 0 ? -1 : 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 38,
                        child: Row(
                          children: [
                            AnimatedRotation(
                              turns: _selectedIndex == 0 ? 0.5 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Image.asset(
                                "assets/icon/arrow_circle_down.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Personal information",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: _customColor.custom242424,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_selectedIndex == 0) const SizedBox(height: 12),
                    if (_selectedIndex == 0)
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: PersonalInfoForm()),
                    Divider(
                      color: _customColor.customEFEFEF,
                      thickness: 1,
                    )
                  ],
                ),

                //Business Profile
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = _selectedIndex == 1 ? -1 : 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 38,
                        child: Row(
                          children: [
                            AnimatedRotation(
                              turns: _selectedIndex == 1 ? 0.5 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Image.asset(
                                "assets/icon/arrow_circle_down.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Business profile",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: _customColor.custom242424,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_selectedIndex == 1) const SizedBox(height: 12),
                    if (_selectedIndex == 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: BusinessProfile(),
                      ),
                    Divider(
                      color: _customColor.customEFEFEF,
                      thickness: 1,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
