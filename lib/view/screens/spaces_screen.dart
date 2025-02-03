import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/current_location.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/check_and_confirm.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_form.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/pre_live_check.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/set_terms.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/about.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/action_buttons.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/ads.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/comment_and_rating.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/more_hot_deals.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/product_images.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/source.dart';
import 'package:tever/view/widgets/spaces_screen/posted_spaces.dart';
import 'package:tever/view/widgets/spaces_screen/section_switcher.dart';

class SpacesScreen extends StatefulWidget {
  const SpacesScreen({super.key});

  @override
  State<SpacesScreen> createState() => _SpacesScreenState();
}

class _SpacesScreenState extends State<SpacesScreen> {
  final CustomColors _customColor = const CustomColors();

  int _selectedSection = 0;

  void _selectSection(int value) {
    setState(() {
      _selectedSection = value;
    });
  }

  void _edit() {
    setState(() {
      _selectedSection = 0;
    });
  }

  void _prev(int value) {
    setState(() {
      _selectedSection = value;
    });
  }

  void _back() {
    Navigator.of(context).pop();
  }

  final List<Widget> _sections = [];

  @override
  void initState() {
    super.initState();
    _sections.addAll([
      Text(""),
      PostedSpaces(),
    ]);
  }

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
                    onPressed: _back,
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
                  "Spaces",
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
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    SectionSwitcher(
                      selectSection: _selectSection,
                      selectedSection: _selectedSection,
                    ),
                    _sections[_selectedSection]
                  ],
                ))),
      ),
    );
  }
}
