import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class AuthenticationLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  final String? subTitle;
  final bool showSubtitle;
  final bool showTitle;
  final bool isScrollable;
  final bool useSafeArea;
  const AuthenticationLayout({
    super.key,
    required this.body,
    this.title,
    this.showTitle = true,
    this.subTitle,
    this.useSafeArea = true,
    this.showSubtitle = true,
    this.isScrollable = true,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final bodySection = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (showTitle) const SizedBox(height: 40),
          if (showTitle)
            Text(
              title.toString(),
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Anybody",
                  color: _customColor.custom242424),
            ),
          if (showSubtitle) const SizedBox(height: 9),
          if (showSubtitle)
            Text(
              subTitle.toString(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom5D5D5D),
            ),
          if (showTitle) const SizedBox(height: 24),
          body
        ]));

    final mainBody =
        isScrollable ? SingleChildScrollView(child: bodySection) : bodySection;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            if (useSafeArea) SafeArea(child: mainBody),
            if (!useSafeArea) mainBody,
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 24,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/image/patterns.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SafeArea(
                      child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Image.asset(
                            "assets/logo/logo_light.png",
                            width: 92.79,
                            height: 24,
                          ))),
                )),
          ])),
    );
  }
}
