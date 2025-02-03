import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

import 'package:tever/view/widgets/new_event_screen/new_event_section.dart';
import 'package:tever/view/widgets/new_event_screen/preview.dart';
import 'package:tever/view/widgets/new_event_screen/save_as_draft_buttom_sheet.dart';
import 'package:tever/view/widgets/new_event_screen/tickets_section.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final CustomColors _customColor = const CustomColors();

  final List<Widget> _pages = [];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _popScreen() {
    Navigator.of(context).pop();
  }

  Future<bool> _handleWillPop() async {
    bool shouldPop = false;
    await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return SaveAsDraftButtomSheet(
          popScreen: () {
            shouldPop = true;
            Navigator.of(context).pop();
          },
        );
      },
    );
    return shouldPop;
  }

  void _showSaveAsDraftBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return SaveAsDraftButtomSheet(popScreen: _popScreen);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      NewEventSection(
        proceed: _selectPage,
      ),
      TicketsSection(
        proceed: _selectPage,
      ),
      const Preview(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        return await _handleWillPop();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 8),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: IconButton(
                          onPressed: _showSaveAsDraftBottomSheet,
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
                        _selectedPageIndex == 0
                            ? "New event"
                            : _selectedPageIndex == 1
                                ? "Tickets"
                                : "Preview",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: _customColor.custom242424,
                            fontFamily: "Anybody"),
                      )
                    ],
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: _customColor.customFDF7ED,
                        borderRadius: BorderRadius.circular(100),
                        border:
                            Border.all(width: 1, color: theme.primaryColor)),
                    child: Text(
                      "${_selectedPageIndex + 1}/3",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: _customColor.custom242424),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: _pages[_selectedPageIndex],
        ),
      ),
    );
  }
}
