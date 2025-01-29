import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/helpers/custom_colors.dart';

class EnterAddressLabeledTextField extends ConsumerWidget {
  final TextEditingController controller;
  final Function? onChange;
  final String? Function(String?)? validator;
  const EnterAddressLabeledTextField(
      {super.key, required this.controller, this.validator, this.onChange});

  final CustomColors _customColor = const CustomColors();

  void useMyCurrentLoction(WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    controller.text = userData.currentAddress.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Enter your address",
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
                const BoxConstraints(maxHeight: 150, maxWidth: 250),
            suffixIcon: GestureDetector(
                onTap: () => useMyCurrentLoction(ref),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                  margin: const EdgeInsets.only(right: 16, left: 8),
                  decoration: BoxDecoration(
                      color: _customColor.customE7F84A,
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    "Use my current location",
                    style: TextStyle(
                        fontSize: 12,
                        color: _customColor.custom242424,
                        fontWeight: FontWeight.w500),
                  ),
                )),
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
              borderSide: BorderSide(
                width: 1,
                color: theme.colorScheme.error,
              ),
            ),
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: _customColor.custom888888,
            ),
          ),
          validator: validator,
          onChanged: (value) => onChange == null ? null : onChange!(value),
        ),
      ],
    );
  }
}
