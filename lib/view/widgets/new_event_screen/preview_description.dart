import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class PreviewDescription extends StatelessWidget {
  final VoidCallback edit;
  final String title;
  final String description;
  final bool useFullRadius;

  const PreviewDescription({
    super.key,
    required this.description,
    required this.edit,
    required this.title,
    required this.useFullRadius,
  });

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 24,
          bottom: useFullRadius ? 22 : 12,
          right: 16,
          left: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: useFullRadius ? const Radius.circular(24) : Radius.zero,
            bottomRight:
                useFullRadius ? const Radius.circular(24) : Radius.zero,
            topLeft: const Radius.circular(24),
            topRight: const Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _customColor.custom242424),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: edit,
                  child: Image.asset(
                    "assets/icon/edit.png",
                    height: 16,
                    width: 16,
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                color: _customColor.customB0B0B0,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            // SizedBox(
            //   height: 120,
            //   child: TextFormField(
            //     style: TextStyle(
            //       color: _customColor.customB0B0B0,
            //       fontSize: 14,
            //     ),
            //     maxLines: null,
            //     minLines: 5,
            //     initialValue:
            //         "Gain access to the event venue and enjoy all the core activities, including keynote sessions, panel discussions, and networking opportunities. This ticket ensures you don’t miss the main event highlights, providing an experience filled with inspiration, learning, and connections.",
            //     decoration: InputDecoration(
            //       hintText: "Enter description",
            //       filled: true,
            //       fillColor: Colors.white,
            //       contentPadding:
            //           const EdgeInsets.only(top: 16, bottom: 16, right: 16),
            //       focusedBorder: InputBorder.none,
            //       enabledBorder: InputBorder.none,
            //       border: InputBorder.none,
            //       errorBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //         borderSide: const BorderSide(width: 1),
            //       ),
            //       hintStyle: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w400,
            //         color: _customColor.custom888888,
            //       ),
            //     ),
            //     onChanged: (value) async {},
            //   ),
            // ),
          ],
        ));
  }
}
