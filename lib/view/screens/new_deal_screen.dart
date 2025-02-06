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

class NewDealScreen extends StatefulWidget {
  final int? selectedSection;
  const NewDealScreen({super.key, this.selectedSection});

  @override
  State<NewDealScreen> createState() => _NewDealScreenState();
}

class _NewDealScreenState extends State<NewDealScreen> {
  final CustomColors _customColor = const CustomColors();

  late int _selectedSection;

  void _next(int value) {
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
    if (_selectedSection == 0) {
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      _selectedSection -= 1;
    });
  }

  final List<Widget> _sections = [];

  @override
  void initState() {
    super.initState();
    _selectedSection = widget.selectedSection ?? 0;

    _sections.addAll([
      NewDealForm(
        next: _next,
      ),
      CheckAndConfirm(
        editDetails: _edit,
        confirm: _next,
      ),
      SetTerms(
        next: _next,
        prev: _prev,
      ),
      const PreLiveCheck()
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
                    // constraints: BoxConstraints(maxHeight: 84, maxWidth: 54),
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
                  _selectedSection == 0
                      ? "New deal"
                      : _selectedSection == 1
                          ? "Review details"
                          : _selectedSection == 2
                              ? "Add terms & policies"
                              : "Add terms & policies",
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
              padding: const EdgeInsets.only(top: 24),
              child: _sections[_selectedSection]),
        ),
      ),
    );
  }
}
