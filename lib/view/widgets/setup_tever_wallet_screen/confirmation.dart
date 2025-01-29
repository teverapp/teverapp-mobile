import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/setup_tever_wallet_screen/match_found.dart';
import 'package:tever/view/widgets/setup_tever_wallet_screen/match_not_found.dart';
import 'package:tever/view/widgets/setup_tever_wallet_screen/match_not_found_upload_docs.dart';
import 'package:tever/view/widgets/setup_tever_wallet_screen/processing_your_identity_verification.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  final CustomColors _customColor = const CustomColors();

  int _activeSection = 0;

  final List<Widget> _sections = [
    MatchFound(),
    MatchNotFoundUploadDocs(),
    MatchNotFound(),
    ProcessingYourIdentityVerification()
  ];

  void _selectSection(int index) {
    if (mounted) {
      setState(() {
        _activeSection = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        //TODO
        //This is either Matched found, Match not found,  or MatchNotFoundUploadDocs to to be implemented during API consumption
        IndexedStack(
          index: _activeSection,
          children: _sections,
        ),
      ],
    );
  }
}
