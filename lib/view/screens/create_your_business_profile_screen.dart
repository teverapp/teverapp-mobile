import 'package:flutter/material.dart';
import 'package:tever/view/widgets/create_your_business_profile_screen.dart/create_buisness_profile_form.dart';
import 'package:tever/view/widgets/general/common/setup_header.dart';

class CreateYourBusinessProfileScreen extends StatelessWidget {
  final bool isCreatedFromNewDeals;
  const CreateYourBusinessProfileScreen({
    super.key,
    required this.isCreatedFromNewDeals,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                  height: 25,
                  width: 25,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      // constraints: BoxConstraints(maxHeight: 84, maxWidth: 54),
                      style: IconButton.styleFrom(padding: EdgeInsets.zero),
                      icon: Image.asset(
                        "assets/icon/arrow_left.png",
                        height: 24,
                        width: 24,
                      )))),
        )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SetupHeader(
                  title: "Create your business profile",
                  subTitle:
                      "Provide the following details to set up your online store front",
                ),
                CreateBuisnessProfileForm(
                  isCreatedFromNewDeals: isCreatedFromNewDeals,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
