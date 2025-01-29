import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tever/helpers/custom_colors.dart';

class OtpInputs extends StatefulWidget {
  final Function submit;
  const OtpInputs({super.key, required this.submit});

  @override
  State<OtpInputs> createState() => _OtpInputsState();
}

class _OtpInputsState extends State<OtpInputs> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final CustomColors _customColor = const CustomColors();

  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<ValueNotifier<bool>> _focusNotifiers =
      List.generate(6, (_) => ValueNotifier<bool>(false));

  void _onFocusChange(int index) {
    _focusNotifiers[index].value = _focusNodes[index].hasFocus;
  }

  void _checkAndSubmit() {
    if (_areAllFieldsFilled()) {
      final otp = _getOTPInput();
      widget.submit(otp);
    }
  }

  bool _areAllFieldsFilled() {
    return _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  void _clearAllFields() {
    for (var controller in _otpControllers) {
      controller.clear();
    }
  }

  void _unfocusField() {
    FocusScope.of(context).unfocus();
  }

  Widget _buildOTPField(
      TextEditingController controller,
      TextEditingController? previous,
      TextEditingController? next,
      FocusNode myFocusNode,
      ValueNotifier<bool> myFocusNotifier) {
    final ThemeData theme = Theme.of(context);

    return ValueListenableBuilder(
      valueListenable: myFocusNotifier,
      builder: (_, isFocus, child) {
        return SizedBox(
          width: 48,
          child: TextFormField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            focusNode: myFocusNode,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 16,
            ),
            contextMenuBuilder: (context, editableTextState) {
              final buttonItems = editableTextState.contextMenuButtonItems;
              final old = buttonItems
                  .where((e) => e.type == ContextMenuButtonType.paste)
                  .firstOrNull;
              if (old == null) {
                return AdaptiveTextSelectionToolbar.editableText(
                  editableTextState: editableTextState,
                );
              }
              final current = old.copyWith(onPressed: () async {
                final clipboardData = await Clipboard.getData('text/plain');
                if (clipboardData?.text != null) {
                  if (clipboardData!.text!.length > 1) {
                    final pastedText = clipboardData.text;

                    _clearAllFields();

                    for (int i = 0; i < _otpControllers.length; i++) {
                      if (i < pastedText!.length) {
                        _otpControllers[i].text = pastedText[i];
                      }
                    }

                    _unfocusField();

                    _checkAndSubmit();
                  }
                }
                editableTextState.hideToolbar();
              });
              buttonItems.remove(old);
              buttonItems.add(current);
              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: editableTextState.contextMenuAnchors,
                buttonItems: buttonItems,
              );
            },
            decoration: InputDecoration(
              hintText: "⚬",
              counterText: "",
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.only(
                  left: 16, right: 16, top: 20, bottom: 20),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: theme.primaryColor,
                  width: 1,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: myFocusNode.hasFocus || controller.text.isNotEmpty
                      ? theme.primaryColor
                      : _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(width: 1),
              ),
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: _customColor.custom888888,
              ),
            ),
            onChanged: (value) async {
              if (value.length > 1) {
                final pastedText = value;

                _clearAllFields();

                for (int i = 0; i < _otpControllers.length; i++) {
                  if (i < pastedText.length) {
                    _otpControllers[i].text = pastedText[i];
                  }
                }

                _unfocusField();

                _checkAndSubmit();
              } else {
                _checkAndSubmit();

                if (value.length == 1 && next != null) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty && previous != null) {
                  FocusScope.of(context).previousFocus();
                }
              }
              // final clipboardData = await Clipboard.getData('text/plain');

              // if (clipboardData?.text != null) {
              //   if (clipboardData!.text!.length == 4) {
              //     final pastedText = clipboardData.text;

              //     _clearAllFields();

              //     for (int i = 0; i < _otpControllers.length; i++) {
              //       if (i < pastedText!.length) {
              //         _otpControllers[i].text = pastedText[i];
              //       }
              //     }

              //     _unfocusField();

              //     _checkAndSubmit();
              //   }
              // }
            },
          ),
        );
      },
    );
  }

  String _getOTPInput() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() => _onFocusChange(i));
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].removeListener(() => _onFocusChange(i));
      _focusNodes[i].dispose();
      _focusNotifiers[i].dispose();
      _otpControllers[i].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          _buildOTPField(_otpControllers[0], null, _otpControllers[1],
              _focusNodes[0], _focusNotifiers[0]),
          const SizedBox(width: 10),
          _buildOTPField(_otpControllers[1], _otpControllers[0],
              _otpControllers[2], _focusNodes[1], _focusNotifiers[1]),
          const SizedBox(width: 10),
          _buildOTPField(_otpControllers[2], _otpControllers[1],
              _otpControllers[3], _focusNodes[2], _focusNotifiers[2]),
          const SizedBox(width: 10),
          _buildOTPField(_otpControllers[3], _otpControllers[2],
              _otpControllers[4], _focusNodes[3], _focusNotifiers[3]),
          const SizedBox(width: 10),
          _buildOTPField(_otpControllers[4], _otpControllers[3],
              _otpControllers[5], _focusNodes[4], _focusNotifiers[4]),
          const SizedBox(width: 10),
          _buildOTPField(_otpControllers[5], _otpControllers[4], null,
              _focusNodes[5], _focusNotifiers[5]),
        ],
      ),
    );
  }
}
