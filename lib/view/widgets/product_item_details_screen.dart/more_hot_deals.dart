import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/product_card.dart';

class MoreHotDeals extends StatelessWidget {
  const MoreHotDeals({super.key});

  final CustomColors _customColor = const CustomColors();

  final List<String> _ratingPlaceHolder = const ["", "", "", ""];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "More hot deals",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _customColor.custom242424),
            ),
            GestureDetector(
              child: Row(
                children: [
                  Text(
                    "Filter",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: theme.primaryColor),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                      height: 16, width: 16, "assets/icon/filter_search.png")
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

            return GridView.builder(
              shrinkWrap:
                  true, // Ensures the grid's height is calculated dynamically
              physics:
                  const NeverScrollableScrollPhysics(), // Prevents internal scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 425, // Fixed height for each grid item
              ),
              itemCount: 10, // Replace with the actual number of items
              itemBuilder: (BuildContext context, int index) {
                return ProductCard();
              },
            );
          },
        )
      ]),
    );
  }
}
