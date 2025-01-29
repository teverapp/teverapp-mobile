import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class TermsAndPolicyBottomSheet extends ConsumerStatefulWidget {
  const TermsAndPolicyBottomSheet({super.key});

  @override
  ConsumerState<TermsAndPolicyBottomSheet> createState() =>
      _TermsAndPolicyBottomSheetState();
}

class _TermsAndPolicyBottomSheetState
    extends ConsumerState<TermsAndPolicyBottomSheet> {
  final CustomColors _customColor = const CustomColors();

  void _selectTermsAndPolicy(
      {required String value, required String id, String? imageUrl}) {
    final selectedFile = DocumentFile(
      title: value,
    );

    ref
        .read(newDealDataProvider.notifier)
        .updateTermsAndPolicy(termsAndPolicy: selectedFile);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  final List<CommonType> _earningValues = [
    CommonType(
      id: "1",
      name: "General terms and conditions",
    ),
    CommonType(
      id: "2",
      name: "Pricing and payment policies",
    ),
    CommonType(
      id: "3",
      name: "Cancellation and rescheduling policies",
    ),
    CommonType(
      id: "4",
      name: "General terms and conditions",
    ),
    CommonType(
      id: "5",
      name: "Pricing and payment policies",
    ),
    CommonType(
      id: "6",
      name: "Privacy and data policies",
    ),
    CommonType(
      id: "7",
      name: "General terms and conditions",
    ),
    CommonType(
      id: "8",
      name: "Pricing and payment policies",
    ),
    CommonType(
      id: "9",
      name: "Liability and disclaimers",
    ),
    CommonType(
      id: "10",
      name: "Content and listing policies",
    ),
    CommonType(
      id: "11",
      name: "Safety and security policies",
    ),
    CommonType(
      id: "12",
      name: "Dispute resolution policies",
    ),
    CommonType(
      id: "13",
      name: "Intellectual property policies",
    ),
    CommonType(
      id: "14",
      name: "Legal compliance policies",
    )
  ];

  @override
  Widget build(BuildContext context) {
    final dealsData = ref.read(newDealDataProvider);

    final mediaQuery = MediaQuery.of(context).size;

    final height = mediaQuery.height * 0.6;

    return SafeArea(
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 30),
            Text(
              "Terms & policies type",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Anybody",
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 14),
            NewDealBottomSheetList(
                hasSelected: true,
                hideBulletPoint: true,
                dropdownItems: _earningValues,
                selectItem: _selectTermsAndPolicy,
                selectedItem: dealsData.type!.name.toString())
          ],
        ),
      ),
    );
  }
}
