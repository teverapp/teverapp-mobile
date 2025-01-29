import 'package:flutter/material.dart';
import 'package:tever/view/widgets/general/common/empty_state.dart';

class OutOfStock extends StatelessWidget {
  const OutOfStock({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      image: "assets/image/out_of_stock.png",
      title: "Sorry, We're Out of Stock.",
      subTitle:
          "Looks like this item is flying off the shelves. Don't worry, you can stay updated",
      buttonText: "Notify Me",
    );
  }
}
