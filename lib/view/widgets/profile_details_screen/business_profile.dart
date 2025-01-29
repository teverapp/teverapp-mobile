import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/qr_code.dart';
import 'package:tever/view/widgets/profile_details_screen/add_a_business_card.dart';
import 'package:tever/view/widgets/profile_details_screen/business_profile_info_form.dart';
import 'package:tever/view/widgets/profile_details_screen/personal_info_form.dart';

class BusinessProfile extends StatefulWidget {
  const BusinessProfile({super.key});

  @override
  State<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Card for creating a busness
        // const AddABusinessCard(),
        const BusinessProfileInfoForm(),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Social media profiles",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424,
            ),
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
        const SizedBox(height: 24),
        const QrCode(),
        const SizedBox(height: 7),
        Text(
          "You can now copy, share or print out your QR code for your physical store or outlet",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: _customColor.custom6D6D6D),
        ),
        const SizedBox(height: 17),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: _customColor.customD1D1D1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text(
              "Save changes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
