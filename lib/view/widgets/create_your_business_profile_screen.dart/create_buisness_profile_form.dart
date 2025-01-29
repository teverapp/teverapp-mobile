import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class CreateBuisnessProfileForm extends StatefulWidget {
  const CreateBuisnessProfileForm({super.key});

  @override
  State<CreateBuisnessProfileForm> createState() =>
      _CreateBuisnessProfileFormState();
}

class _CreateBuisnessProfileFormState extends State<CreateBuisnessProfileForm> {
  final CustomColors _customColor = const CustomColors();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
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
              color: _customColor.custom888888,
            ),
          ),
          onChanged: (value) async {},
        ),
        const SizedBox(height: 16),
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
              color: _customColor.custom888888,
            ),
          ),
          onChanged: (value) async {},
        ),
        const SizedBox(height: 16),
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
              color: _customColor.custom888888,
            ),
          ),
          onChanged: (value) async {},
        ),
        const SizedBox(height: 16),
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
              color: _customColor.custom888888,
            ),
          ),
          onChanged: (value) async {},
        ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 10),
        Text(
          "Type in your address or triangulate to get the exact coordinates of your store/business location",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: _customColor.custom5D5D5D),
        ),
        const SizedBox(height: 16),
        Text(
          "Social media profiles",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _customColor.custom242424,
          ),
        ),
        const SizedBox(height: 7),
        TextFormField(
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Copy & paste URL",
            filled: true,
            fillColor: Colors.white,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 16, right: 8),
              child: Image.asset(
                "assets/icon/tiktok_black.png",
                height: 20,
                width: 20,
              ),
            ),
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
              color: _customColor.custom888888,
            ),
          ),
          onChanged: (value) async {},
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Copy & paste URL",
            filled: true,
            fillColor: Colors.white,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 16, right: 8),
              child: Image.asset(
                "assets/icon/twitter_black.png",
                height: 20,
                width: 20,
              ),
            ),
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
              color: _customColor.custom888888,
            ),
          ),
          onChanged: (value) async {},
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Copy & paste URL",
            filled: true,
            fillColor: Colors.white,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 16, right: 8),
              child: Image.asset(
                "assets/icon/instagram_black.png",
                height: 20,
                width: 20,
              ),
            ),
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
              color: _customColor.custom888888,
            ),
          ),
          onChanged: (value) async {},
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Copy & paste URL",
            filled: true,
            fillColor: Colors.white,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 16, right: 8),
              child: Image.asset(
                "assets/icon/threads_black.png",
                height: 20,
                width: 20,
              ),
            ),
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
              color: _customColor.custom888888,
            ),
          ),
          onChanged: (value) async {},
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Copy & paste URL",
            filled: true,
            fillColor: Colors.white,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 16, right: 8),
              child: Image.asset(
                "assets/icon/facebook_black.png",
                height: 20,
                width: 20,
              ),
            ),
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
              color: _customColor.custom888888,
            ),
          ),
          onChanged: (value) async {},
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text(
              "Save details",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
