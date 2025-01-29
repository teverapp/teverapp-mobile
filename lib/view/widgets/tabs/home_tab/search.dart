import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final CustomColors _customColor = const CustomColors();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: _customColor.custom242424,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: "Start typing...",
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
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 150, maxWidth: 150),
        suffixIcon: Container(
          padding: const EdgeInsets.only(right: 11),
          margin: const EdgeInsets.only(right: 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/icon/microphone.png", height: 21, width: 21),
              const SizedBox(width: 20),
              Image.asset("assets/icon/gallery.png", height: 21, width: 21),
            ],
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
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w400,
          color: _customColor.custom888888,
        ),
      ),
      onChanged: (value) async {},
    );
  }
}
