import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/rotate_image.dart';

class WaitingScreen extends StatelessWidget {
  final String title;
  final bool hideScaffold;
  const WaitingScreen({
    super.key,
    required this.title,
    this.hideScaffold = false,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final body = Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const RotateImage(
              imageHeight: 200,
              imageUrl: "assets/image/loading.png",
              imageWidth: 200),
          const SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: _customColor.custom2E3438,
            ),
          ),
        ],
      ),
    );
    return hideScaffold
        ? body
        : Scaffold(
            body: body,
          );
  }
}
