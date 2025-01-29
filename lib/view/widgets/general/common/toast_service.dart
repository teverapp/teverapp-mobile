import 'package:flutter/material.dart';
import 'package:tever/controller/input_validation_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';

class ToastService {
  static OverlayEntry? _currentToast;

  static void showToast({
    required BuildContext context,
    required String message,
    required String status,
  }) {
    _removeCurrentToast();

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: _SlideInToast(
            message: message,
            status: status,
            onClose: () {
              overlayEntry.remove();
              _currentToast = null;
            },
          ),
        );
      },
    );

    _currentToast = overlayEntry;

    overlay.insert(overlayEntry);

    // Automatically remove the toast after a delay
    Future.delayed(const Duration(seconds: 6), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
        if (_currentToast == overlayEntry) {
          _currentToast = null; // Clear reference if it's the same toast
        }
      }
    });
  }

  static void _removeCurrentToast() {
    // Remove the current toast if it exists
    if (_currentToast?.mounted ?? false) {
      _currentToast!.remove();
      _currentToast = null;
    }
  }
}

class _SlideInToast extends StatefulWidget {
  final String message;
  final VoidCallback onClose;
  final String status;

  const _SlideInToast(
      {required this.message, required this.onClose, required this.status});

  @override
  State<_SlideInToast> createState() => __SlideInToastState();
}

class __SlideInToastState extends State<_SlideInToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  final CustomColors _customColor = const CustomColors();

  final InputValidationController _validate = InputValidationController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _controller.reverse().then((_) {
          widget.onClose();
        });
      }
    });
  }

  void _closeToast() {
    _controller.reverse().then((_) {
      widget.onClose();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leadingIcon = ToastStatus.success.name == widget.status
        ? "tick_circle_dark_green.png"
        : ToastStatus.info.name == widget.status
            ? "info_circle.png"
            : ToastStatus.warning.name == widget.status
                ? "warning_flag.png"
                : "caution_outline.png";

    final closeIcon = ToastStatus.success.name == widget.status
        ? "close_circle_light_green.png"
        : ToastStatus.info.name == widget.status
            ? "info_close_circle.png"
            : ToastStatus.warning.name == widget.status
                ? "warning_close_circle.png"
                : "close_circle_light_orange.png";

    final textColor = ToastStatus.success.name == widget.status
        ? _customColor.custom08745B
        : ToastStatus.info.name == widget.status
            ? _customColor.custom1F5B85
            : ToastStatus.warning.name == widget.status
                ? _customColor.custom6E810A
                : _customColor.customB12524;

    final bottomBorderColor = ToastStatus.success.name == widget.status
        ? _customColor.custom72E3BC
        : ToastStatus.info.name == widget.status
            ? _customColor.custom93C6E6
            : ToastStatus.warning.name == widget.status
                ? _customColor.customE7F84A
                : _customColor.customF7ABAA;

    final bgColor = ToastStatus.success.name == widget.status
        ? _customColor.customD2F9E7
        : ToastStatus.info.name == widget.status
            ? _customColor.customE5F0F9
            : ToastStatus.warning.name == widget.status
                ? _customColor.customFBFEC9
                : _customColor.customFDE3E3;

    print("${ToastStatus.success.name} ${widget.status}");

    //info_close_circle.png
    //close_circle_light_green.png
    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 17),
          padding: const EdgeInsets.only(
            top: 16,
            right: 16,
            left: 16,
            bottom: 24,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 32,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: bottomBorderColor,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icon/$leadingIcon",
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _validate.capitalizeFirstLetter(widget.status),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: _closeToast,
                      child: Image.asset(
                        "assets/icon/$closeIcon",
                        height: 16,
                        width: 16,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.message,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
