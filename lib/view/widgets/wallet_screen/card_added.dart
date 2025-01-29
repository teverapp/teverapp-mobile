import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class CardAdded extends StatelessWidget {
  const CardAdded({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: _customColor.custom242424,
        fontSize: 14,
      ),
      initialValue: "*** 3232",
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: _customColor.customEFEFEF,
            width: 1,
          ),
        ),
        prefixIconConstraints:
            const BoxConstraints(maxHeight: 150, maxWidth: 150),
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: 16, right: 8),
          child: Image.asset(
            "assets/icon/master_card.png",
            height: 16.07,
            width: 26,
          ),
        ),
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 150, maxWidth: 150),
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: 16),
          child: Image.asset("assets/icon/radio_active_circular.png",
              height: 24, width: 24),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: _customColor.customEFEFEF,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: _customColor.customEFEFEF,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1),
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: _customColor.custom888888,
        ),
      ),
      onChanged: (value) async {},
    );
  }
}
