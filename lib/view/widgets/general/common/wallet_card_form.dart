import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class WalletCardForm extends StatefulWidget {
  const WalletCardForm({super.key});

  @override
  State<WalletCardForm> createState() => _WalletCardFormState();
}

class _WalletCardFormState extends State<WalletCardForm> {
  final CustomColors _customColor = const CustomColors();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Card number",
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
          initialValue: "5533 1000 1000",
          decoration: InputDecoration(
            hintText: "Enter card number",
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
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            suffixIcon: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Image.asset(
                "assets/icon/master_card.png",
                height: 16,
                width: 28.47,
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
        const SizedBox(height: 16),
        Text(
          "Cardholder's name",
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
          initialValue: "John Doe",
          decoration: InputDecoration(
            hintText: "Enter cardholder's name",
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
        const SizedBox(height: 16),
        Text(
          "Expiry date",
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
          initialValue: "10/10/2030",
          decoration: InputDecoration(
            hintText: "00/00/0000",
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
        const SizedBox(height: 16),
        Text(
          "CVV",
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
          initialValue: "101",
          decoration: InputDecoration(
            hintText: "Enter CCV",
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
      ],
    );
  }
}
