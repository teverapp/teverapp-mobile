import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/general/common/current_location.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/about.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/action_buttons.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/ads.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/comment_and_rating.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/more_hot_deals.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/product_images.dart';
import 'package:tever/view/widgets/product_item_details_screen.dart/source.dart';

class ProductItemDetailsScreen extends StatelessWidget {
  const ProductItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: IconButton.styleFrom(padding: EdgeInsets.zero),
                          icon: Image.asset(
                            "assets/icon/arrow_left.png",
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                      const CurrentLocation()
                    ],
                  )))),
      body: const SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: EdgeInsets.only(right: 16, left: 16, top: 24),
        child: Column(
          children: [
            Source(),
            SizedBox(height: 8),
            ProductImages(),
            SizedBox(height: 8),
            ActionButtons(),
            SizedBox(height: 8),
            CommentAndRating(),
            SizedBox(height: 8),
            About(),
            SizedBox(height: 8),
            Ads(),
            SizedBox(height: 8),
            MoreHotDeals(),
            SizedBox(height: 8),
          ],
        ),
      ))),
    );
  }
}
