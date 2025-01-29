import 'package:flutter/material.dart';
import 'package:tever/view/widgets/general/common/product_card.dart';

class TrendingItems extends StatelessWidget {
  const TrendingItems({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
    );
  }
}
