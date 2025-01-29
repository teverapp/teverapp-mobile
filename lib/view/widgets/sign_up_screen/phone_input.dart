import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:tever/controller/app_info_controller.dart";
import "package:tever/controller/input_validation_controller.dart";
import "package:tever/helpers/custom_colors.dart";
import "package:tever/view/widgets/get_started_sreen/country_bottom_sheet.dart";

class PhoneInput extends ConsumerStatefulWidget {
  final TextEditingController? controller;
  final bool hideTopGap;
  final bool hideDropDownIcon;
  final String? selectedCountryFlag;
  final String? selectedCountryPhoneCode;
  final String? selectedCountryAcronym;
  final Function? onSave;
  final Function? validator;
  final bool readOnly;
  final GlobalKey<FormFieldState<String>>? phoneKey;
  final Color? bgColor;
  final Function? selectCountry;
  final Function? onChange;

  const PhoneInput(
      {super.key,
      this.validator,
      this.hideTopGap = false,
      this.hideDropDownIcon = true,
      this.selectedCountryFlag,
      this.selectedCountryAcronym,
      this.selectedCountryPhoneCode,
      this.onSave,
      this.phoneKey,
      this.readOnly = false,
      this.bgColor,
      this.controller,
      this.selectCountry,
      this.onChange});

  @override
  ConsumerState<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends ConsumerState<PhoneInput>
    with SingleTickerProviderStateMixin {
  final CustomColors _customColors = const CustomColors();

  late TextEditingController _phoneController;

  final InputValidationController _validationController =
      InputValidationController();

  String? _errorMessage;

  String? _validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return _updateErrorMessage('Please enter phone number!');
    }
    if (!_validationController.validatePhoneNumber(value)) {
      return _updateErrorMessage('Invalid phone number format');
    }

    if (widget.onChange != null) {
      widget.onChange!(value);
    }

    return _updateErrorMessage(null);
  }

  String? _updateErrorMessage(String? message) {
    setState(() {
      _errorMessage = message;
    });
    if (widget.validator != null) {
      widget.validator!(message != null);
    }

    return null;
  }

  void _formatPhoneNumber(String value) {
    final selectedCountry = ref.watch(appInfoProvider);

    final selectedCountryPhoneCode =
        widget.selectedCountryPhoneCode ?? selectedCountry.phoneCode;

    if (!value.startsWith(selectedCountryPhoneCode)) {
      final sanitizedValue = value.replaceFirst(RegExp(r"^\+?\d*"), "");

      _phoneController.text = "$selectedCountryPhoneCode$sanitizedValue";

      _phoneController.selection =
          TextSelection.collapsed(offset: _phoneController.text.length);
    }
  }

  void _showCountryBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return CountryBottomSheet(onTap: widget.selectCountry as Function);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _phoneController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _phoneController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final selectedCountry = ref.watch(appInfoProvider);

    final selectedCountryPhoneCode =
        widget.selectedCountryPhoneCode ?? selectedCountry.phoneCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.hideTopGap) const SizedBox(height: 24),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: _errorMessage != null
                  ? theme.colorScheme.error
                  : _customColors.customEFEFEF,
            ),
          ),
          child: Row(
            children: [
              _buildCountrySelector(),
              Expanded(
                child: TextFormField(
                  key: widget.phoneKey,
                  readOnly: widget.readOnly,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  autocorrect: true,
                  enableSuggestions: true,
                  onTap: () => _formatPhoneNumber(_phoneController.text),
                  onChanged: (value) {
                    _formatPhoneNumber(value);
                    _validatePhoneNumber(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16, bottom: 1),
                    border: InputBorder.none,
                    hintText: "$selectedCountryPhoneCode (000) 000-0000",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: _customColors.custom888888,
                    ),
                  ),
                  validator: (value) => _validatePhoneNumber(value ?? ""),
                  onSaved: (value) {
                    if (widget.onSave != null) {
                      widget.onSave!(value);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              _errorMessage!,
              style: TextStyle(fontSize: 12, color: theme.colorScheme.error),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCountrySelector() {
    final selectedCountry = ref.watch(appInfoProvider);
    return GestureDetector(
      onTap: !widget.hideDropDownIcon ? () => _showCountryBottomSheet() : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 1, color: _customColors.customEFEFEF),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: OverflowBox(
                    maxWidth: double.infinity,
                    maxHeight: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        widget.selectedCountryFlag ?? selectedCountry.flag,
                        style: const TextStyle(fontSize: 35),
                      ),
                    ),
                  )),
            ),
            const SizedBox(width: 10),
            Text(
              widget.selectedCountryAcronym ?? selectedCountry.countryCode,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _customColors.custom242424,
              ),
            ),
            if (!widget.hideDropDownIcon) ...[
              const SizedBox(width: 10),
              Image.asset(
                "assets/icon/arrow_down.png",
                height: 16,
                width: 16,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
