import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  final CustomColors _customColor = const CustomColors();

  Widget _buildDropDownButton(
      {required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: _customColor.customEFEFEF))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom242424,
                  fontSize: 16),
            ),
            Image.asset(
              "assets/icon/drop_down.png",
              height: 20,
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        children: [
          SizedBox(
            height: 48,
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  "assets/icon/shopping_cart_orange.png",
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Buy now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ]),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: _customColor.customF9E8CC,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  "assets/icon/heart.png",
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _customColor.customC75818,
                  ),
                )
              ]),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: theme.primaryColor, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  "assets/icon/sent.png",
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  "Share",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: theme.primaryColor,
                  ),
                )
              ]),
            ),
          ),
          const SizedBox(height: 16),
          Divider(
            color: _customColor.customEFEFEF,
            thickness: 1,
          ),
          const SizedBox(height: 20),
          _buildDropDownButton(title: "Description", onTap: () {}),
          const SizedBox(height: 16),
          _buildDropDownButton(title: "Shipping", onTap: () {}),
          const SizedBox(height: 16),
          _buildDropDownButton(title: "Terms & policies", onTap: () {}),
        ],
      ),
    );
  }
}
