import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class SwitchButton extends StatefulWidget {
  final bool isOn;
  final VoidCallback toggleHandler;
  const SwitchButton(
      {super.key, required this.toggleHandler, required this.isOn});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  final CustomColors _customColor = const CustomColors();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.toggleHandler,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 24,
        width: 44,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.isOn ? theme.primaryColor : _customColor.customEFEFEF,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: widget.isOn ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.easeInOut,
          child: Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Image.asset(
              widget.isOn
                  ? "assets/icon/check_orange.png"
                  : "assets/icon/x.png",
              height: 12,
              width: 12,
            ),
          ),
        ),
      ),
    );
  }
}
