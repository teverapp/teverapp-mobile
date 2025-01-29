import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/sign_up_screen/email_input.dart';
import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';

class BusinessProfileInfoForm extends StatefulWidget {
  const BusinessProfileInfoForm({super.key});

  @override
  State<BusinessProfileInfoForm> createState() =>
      _BusinessProfileInfoFormState();
}

class _BusinessProfileInfoFormState extends State<BusinessProfileInfoForm> {
  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Business name",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        TextFormField(
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Name you registered as business name",
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 16),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _customColor.customEFEFEF,
                width: 1,
              ),
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
        ),
        const SizedBox(height: 14),
        Text(
          "Brand/ trade name",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        TextFormField(
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Name you trade with",
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 16),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _customColor.customEFEFEF,
                width: 1,
              ),
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
        ),
        const SizedBox(height: 14),
        Text(
          "Business type",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        TextFormField(
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Choose all that apply",
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 16),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _customColor.customEFEFEF,
                width: 1,
              ),
            ),
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            suffixIcon: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Image.asset(
                "assets/icon/drop_down.png",
                height: 16,
                width: 16,
              ),
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
              color: _customColor.custom242424,
            ),
          ),
          onChanged: (value) async {},
        ),
        const SizedBox(height: 14),
        Text(
          "Industry",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        TextFormField(
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Choose all that apply",
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 16),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _customColor.customEFEFEF,
                width: 1,
              ),
            ),
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            suffixIcon: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Image.asset(
                "assets/icon/drop_down.png",
                height: 16,
                width: 16,
              ),
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
              color: _customColor.custom242424,
            ),
          ),
          onChanged: (value) async {},
        ),
        const SizedBox(height: 14),
        Text(
          "Address",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        TextFormField(
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Enter address or...",
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 16),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _customColor.customEFEFEF,
                width: 1,
              ),
            ),
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            suffixIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                  color: _customColor.customE7F84A,
                  borderRadius: BorderRadius.circular(100)),
              child: const Text(
                "Triangulate",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
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
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          "Type in your address or triangulate to get the exact coordinates of your location",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: _customColor.custom5D5D5D),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
