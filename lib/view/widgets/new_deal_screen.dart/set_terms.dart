import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/business_profile.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/custom_input_selection_button.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/add_a_business_button.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/check_and_confirm_card.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/post_deal_button.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/terms_and_policy_bottom_sheet.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/terms_and_policy_card.dart';

class SetTerms extends ConsumerStatefulWidget {
  final Function next;
  final Function prev;
  const SetTerms({
    super.key,
    required this.next,
    required this.prev,
  });

  @override
  ConsumerState<SetTerms> createState() => _SetTermsState();
}

class _SetTermsState extends ConsumerState<SetTerms> {
  final CustomColors _customColor = const CustomColors();

  int _selectedIndex = 0;

  void _showTermsAndPolicyBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const TermsAndPolicyBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final newDealsData = ref.watch(newDealDataProvider);

    final businessProfileDealsData = ref.watch(businessProfileProvider);

    final userData = ref.watch(userDataProvider);

    final hasUserCreatedABusiness = userData.hasCreatedABusiness ?? false;

    return Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set terms and include your contact information",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom242424),
            ),
            Column(children: [
              const SizedBox(height: 26),
              // Terms & policies
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = _selectedIndex == 0 ? -1 : 0;
                          });
                        },
                        child: Container(
                          height: 38,
                          color: Colors.transparent,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Terms & policies",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: _customColor.custom242424,
                                  ),
                                ),
                                AnimatedRotation(
                                  turns: _selectedIndex == 0 ? 0.5 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Image.asset(
                                    "assets/icon/drop_down.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      if (_selectedIndex == 0) const SizedBox(height: 10),
                      if (_selectedIndex == 0)
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Type",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: _customColor.custom242424),
                                ),
                                const SizedBox(height: 9),
                                CustomInputSelectionButton(
                                    selectedItem: "Choose an option!",
                                    hasSelected: false,
                                    onTap: _showTermsAndPolicyBottomSheet),
                                const SizedBox(height: 13),
                                if (newDealsData
                                    .selectedTermsAndPolicy.isNotEmpty)
                                  Column(
                                    children: newDealsData
                                        .selectedTermsAndPolicy
                                        .asMap()
                                        .entries
                                        .map((entry) => TermsAndPolicyCard(
                                            hideBottomBorder: entry.key ==
                                                newDealsData
                                                        .selectedTermsAndPolicy
                                                        .length -
                                                    1,
                                            id: entry.value.id!,
                                            docFile: entry.value.doc,
                                            content: entry.value.content ?? "",
                                            title: entry.value.title.toString(),
                                            fileName: entry.value.docName))
                                        .toList(),
                                  ),
                              ],
                            )),
                      const SizedBox(height: 7),
                      Divider(
                        color: _customColor.customEFEFEF,
                        thickness: 1,
                      )
                    ],
                  ),
                ),
              ),
              if (!hasUserCreatedABusiness)
                // Contact information
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = _selectedIndex == 1 ? -1 : 1;
                            });
                          },
                          child: Container(
                            height: 38,
                            color: Colors.transparent,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Store information (Required)",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: _customColor.custom242424,
                                    ),
                                  ),
                                  AnimatedRotation(
                                    turns: _selectedIndex == 1 ? 0.5 : 1,
                                    duration: const Duration(milliseconds: 300),
                                    child: Image.asset(
                                      "assets/icon/drop_down.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        if (_selectedIndex == 1) ...[
                          const SizedBox(height: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!newDealsData.hasCreatedABussinessProfile)
                                  const AddABusinessButton(),
                                if (newDealsData
                                    .hasCreatedABussinessProfile) ...[
                                  CheckAndConfirmCard(
                                    label: "Business Logo",
                                    image:
                                        businessProfileDealsData.businessLogo,
                                  ),
                                  CheckAndConfirmCard(
                                    label: "Business name",
                                    value:
                                        businessProfileDealsData.businessName,
                                  ),
                                  CheckAndConfirmCard(
                                    label: "Brand/ trade name",
                                    value: businessProfileDealsData.brandName,
                                  ),
                                  CheckAndConfirmCard(
                                    label: "Business type",
                                    value: businessProfileDealsData.businessType
                                        .toString(),
                                  ),
                                  CheckAndConfirmCard(
                                    label: "Industry",
                                    value: businessProfileDealsData.industry
                                        .toString(),
                                  ),
                                  CheckAndConfirmCard(
                                    label: "About business",
                                    value: businessProfileDealsData
                                        .aboutBusiness
                                        .toString(),
                                  ),
                                  CheckAndConfirmCard(
                                    label: "Business email address",
                                    value: businessProfileDealsData.email
                                        .toString(),
                                  ),
                                  CheckAndConfirmCard(
                                    label: "Phone number",
                                    value: businessProfileDealsData.phoneNumber
                                        .toString(),
                                  ),
                                  CheckAndConfirmCard(
                                    label: "Address",
                                    value: businessProfileDealsData
                                        .address!.locationName
                                        .toString(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Container(
                                      height: 37,
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                        width: 1,
                                        color: _customColor.customEFEFEF,
                                      ))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Social media",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color:
                                                    theme.colorScheme.primary),
                                          ),
                                          const SizedBox(width: 20),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/icon/${businessProfileDealsData.tiktokUrl.imageUrl}",
                                                height: 20,
                                                width: 20,
                                              ),
                                              const SizedBox(width: 16),
                                              Image.asset(
                                                "assets/icon/${businessProfileDealsData.twitterUrl.imageUrl}",
                                                height: 20,
                                                width: 20,
                                              ),
                                              const SizedBox(width: 16),
                                              Image.asset(
                                                "assets/icon/${businessProfileDealsData.facebookUrl.imageUrl}",
                                                height: 20,
                                                width: 20,
                                              ),
                                              const SizedBox(width: 16),
                                              Image.asset(
                                                "assets/icon/${businessProfileDealsData.instagramUrl.imageUrl}",
                                                height: 20,
                                                width: 20,
                                              ),
                                              const SizedBox(width: 16),
                                              Image.asset(
                                                "assets/icon/${businessProfileDealsData.threadsUrl.imageUrl}",
                                                height: 20,
                                                width: 20,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ]
                              ])
                        ],
                        Divider(
                          color: _customColor.customEFEFEF,
                          thickness: 1,
                        )
                      ],
                    ),
                  ),
                ),
            ]),
            const SizedBox(height: 183),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                        onPressed: () => widget.prev(1),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: theme.colorScheme.error, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.error,
                          ),
                        )),
                  ),
                ),
                const SizedBox(width: 20),
                PostDealButton(next: widget.next)
              ],
            ),
            const SizedBox(height: 40),
          ],
        ));
  }
}
