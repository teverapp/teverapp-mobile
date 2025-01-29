import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/complete_your_profile_screen/complete_profile_form.dart';
import 'package:tever/view/widgets/general/common/setup_header.dart';
import 'package:tever/view/widgets/setup_tever_wallet_screen/confirmation.dart';
import 'package:tever/view/widgets/setup_tever_wallet_screen/facial_matching.dart';
import 'package:tever/view/widgets/setup_tever_wallet_screen/choose_id_type_form.dart';

class SetupTeverWalletScreen extends StatefulWidget {
  const SetupTeverWalletScreen({super.key});

  @override
  State<SetupTeverWalletScreen> createState() => _SetupTeverWalletScreenState();
}

class _SetupTeverWalletScreenState extends State<SetupTeverWalletScreen> {
  final CustomColors _customColor = const CustomColors();

  int _activeSection = 0;

  final List<Widget> _sections = [
    const ChooseIdTypeForm(),
    const FacialMatching(),
    const Confirmation()
  ];

  void _selectSection(int index) {
    if (mounted) {
      setState(() {
        _activeSection = index;
      });
    }
  }

  void _popScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

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
                      onPressed: () => _popScreen(context),
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
                SetupHeader(
                  title: _activeSection == 2
                      ? "Confirmation"
                      : "Set up Tever wallet",
                  subTitle: _activeSection == 2
                      ? null
                      : "Verify your identity to enable wallet features",
                ),
                IndexedStack(
                  index: _activeSection,
                  children: _sections,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
