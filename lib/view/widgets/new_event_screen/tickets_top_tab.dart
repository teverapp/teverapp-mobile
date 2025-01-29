import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class TicketsTopTab extends StatefulWidget {
  final Function selectTicket;
  const TicketsTopTab({super.key, required this.selectTicket});

  @override
  State<TicketsTopTab> createState() => _TicketsTopTabState();
}

class _TicketsTopTabState extends State<TicketsTopTab> {
  final CustomColors _customColor = const CustomColors();

  int _activeSection = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 51,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: _customColor.customEFEFEF,
          border: Border.all(width: 1, color: _customColor.customDCDCDC),
          borderRadius: BorderRadius.circular(60)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    _activeSection = 0;
                  });
                  widget.selectTicket(0);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: _activeSection == 0
                          ? _customColor.customFDF7ED
                          : Colors.transparent,
                      border: Border.all(
                        width: 1,
                        color: _activeSection == 0
                            ? theme.primaryColor
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Free Ticket",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _activeSection == 0
                            ? theme.primaryColor
                            : _customColor.custom7C7C7C),
                  ),
                )),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _activeSection = 1;
                });
                widget.selectTicket(1);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: _activeSection == 1
                        ? _customColor.customFDF7ED
                        : Colors.transparent,
                    border: Border.all(
                      width: 1,
                      color: _activeSection == 1
                          ? theme.primaryColor
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Paid Ticket",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: _activeSection == 1
                          ? theme.primaryColor
                          : _customColor.custom7C7C7C),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
