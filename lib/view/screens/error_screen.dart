import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback retry;
  final String? errorMessage;
  final bool isNetworkError;
  final bool showScaffold;
  const ErrorScreen(
      {super.key,
      required this.retry,
      required this.isNetworkError,
      this.showScaffold = true,
      this.errorMessage});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final image = isNetworkError ? "data_empty.png" : "blogs_empty.png";

    final body = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icon/$image",
          height: 140,
          width: 140,
        ),
        const SizedBox(height: 24, width: double.infinity),
        Text(
          isNetworkError ? "Connection lost" : "Oops",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: _customColor.custom242424,
          ),
        ),
        const SizedBox(height: 8),
        Container(
            constraints: const BoxConstraints(maxWidth: 350),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              errorMessage != null
                  ? errorMessage.toString()
                  : isNetworkError
                      ? "We noticed a network error. Please check the strength of your internet connection."
                      : "Looks like something went wrong",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424,
              ),
            )),
        const SizedBox(height: 24),
        SizedBox(
          height: 48,
          width: 264,
          child: TextButton(
            onPressed: retry,
            style: TextButton.styleFrom(
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text(
              "Try again",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );

    return showScaffold ? Scaffold(body: body) : body;
  }
}
