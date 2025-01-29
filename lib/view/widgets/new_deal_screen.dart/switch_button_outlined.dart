import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class SwitchButtonOutlined extends StatefulWidget {
  final bool isOn;
  final VoidCallback toggleHandler;
  const SwitchButtonOutlined(
      {super.key, required this.toggleHandler, required this.isOn});

  @override
  State<SwitchButtonOutlined> createState() => _SwitchButtonOutlinedState();
}

class _SwitchButtonOutlinedState extends State<SwitchButtonOutlined> {
  final CustomColors _customColor = const CustomColors();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.toggleHandler,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 20,
        width: 36,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: widget.isOn ? theme.primaryColor : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(20),
          color: widget.isOn
              ? _customColor.customFDF7ED
              : _customColor.customDCDCDC,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: widget.isOn ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.easeInOut,
          child: Container(
            height: 16,
            width: 16,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isOn ? theme.primaryColor : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
