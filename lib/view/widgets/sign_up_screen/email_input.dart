import 'package:flutter/material.dart';
import 'package:tever/controller/input_validation_controller.dart';
import 'package:tever/helpers/custom_colors.dart';

class EmailInput extends StatefulWidget {
  final bool hideTopGap;
  final TextEditingController? controller;
  final String? leadingIcon;
  final double? leadingIconHeight;
  final double? leadingIconWidth;
  final Function? validator;
  final Function? onSave;
  final bool readOnly;
  final GlobalKey<FormFieldState<String>>? emailKey;
  final Color? bgColor;
  final Function? onChange;

  const EmailInput({
    super.key,
    this.validator,
    this.leadingIcon,
    this.leadingIconHeight,
    this.leadingIconWidth,
    this.hideTopGap = false,
    this.onSave,
    this.emailKey,
    this.controller,
    this.readOnly = false,
    this.bgColor,
    this.onChange,
  });

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  final CustomColors _customColor = const CustomColors();

  final InputValidationController _validateInput = InputValidationController();

  String? _errorMessage;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      _updateErrorMessage('Email is required');

      return null;
    }

    if (!_validateInput.validateEmail(value)) {
      _updateErrorMessage('Invalid email!');

      return null;
    }

    if (widget.onChange != null) {
      widget.onChange!(value);
    }

    _updateErrorMessage(null);
    return null;
  }

  void _updateErrorMessage(String? errorMessage) {
    setState(() => _errorMessage = errorMessage);
    if (widget.validator != null) {
      widget.validator!(errorMessage != null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  : _customColor.customEFEFEF,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16, right: 15),
                height: double.infinity,
                child: Image.asset(widget.leadingIcon ?? "assets/icon/mail.png",
                    height: widget.leadingIconHeight ?? 20,
                    width: widget.leadingIconWidth ?? 20),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    readOnly: widget.readOnly,
                    key: widget.emailKey == null ? widget.emailKey : null,
                    controller: widget.controller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      border: InputBorder.none,
                      hintText: 'you@email.com',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: _customColor.custom888888),
                    ),
                    onChanged: _validateEmail,
                    validator: _validateEmail,
                    onSaved: (value) {
                      if (widget.onSave != null) {
                        widget.onSave!(value);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 4),
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
}
