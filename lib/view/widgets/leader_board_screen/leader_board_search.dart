import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class LeaderBoardSearch extends StatefulWidget {
  const LeaderBoardSearch({super.key});

  @override
  State<LeaderBoardSearch> createState() => _LeaderBoardSearchState();
}

class _LeaderBoardSearchState extends State<LeaderBoardSearch> {
  final CustomColors _customColor = const CustomColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 1, right: 16, left: 16, bottom: 24),
      color: Colors.white,
      child: TextFormField(
        style: TextStyle(
          color: _customColor.custom242424,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: "Search...",
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(8),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
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
              "assets/icon/search_orange.png",
              height: 21,
              width: 21,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: _customColor.customEFEFEF,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: _customColor.customEFEFEF,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(width: 1),
          ),
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: _customColor.custom888888,
          ),
        ),
        onChanged: (value) async {},
      ),
    );
  }
}
