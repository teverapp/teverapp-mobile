import 'package:flutter/material.dart';
import 'package:tever/view/widgets/general/common/empty_state.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      image: "assets/icon/empty_cart.png",
      title: "Let's fill it up with things you'll love.",
      subTitle: "Your cart is empty",
      buttonText: "Explore Deals",
    );
  }
}
