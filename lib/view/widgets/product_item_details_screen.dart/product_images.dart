import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({super.key});

  final CustomColors _customColor = const CustomColors();

  Widget _buildImageCard({required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.47, color: _customColor.customEFEFEF)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          "assets/image/trending_image_placeholder.png",
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildButton(
      {required String label, required String icon, required ThemeData theme}) {
    return Row(
      children: [
        Image.asset(
          "assets/icon/$icon",
          height: 24,
          width: 24,
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.primaryColor),
        )
      ],
    );
  }

  final List<String> tags = const ["tags", "tags", "tags"];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        children: [
          _buildImageCard(height: 232),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildImageCard(height: 75)),
              const SizedBox(width: 8),
              Expanded(child: _buildImageCard(height: 75)),
              const SizedBox(width: 8),
              Expanded(child: _buildImageCard(height: 75))
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                  children: tags
                      .asMap()
                      .entries
                      .map((entry) => Container(
                            margin: EdgeInsets.only(
                                right: tags.length - 1 == entry.key ? 0 : 8),
                            decoration: BoxDecoration(
                                color: _customColor.customF6F3FF,
                                borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Text(
                                "tags",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: _customColor.custom965CF6),
                              ),
                            ),
                          ))
                      .toList()),
              const SizedBox(width: 5),
              Row(
                children: [
                  _buildButton(label: "20", icon: "liked.png", theme: theme),
                  const SizedBox(width: 20),
                  _buildButton(label: "5", icon: "messaged.png", theme: theme),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
