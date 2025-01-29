import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class Source extends StatelessWidget {
  final bool showRating;
  const Source({super.key, this.showRating = true});
  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    int _noOfSelecteedRating = 3;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Source",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _customColor.custom4F4F4F),
              ),
              Text(
                "1 day ago",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: _customColor.custom888888,
                    fontStyle: FontStyle.italic),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Exclusive Luxe Clutch Bag Collection - 30% discount for a limited time only! ",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                color: _customColor.custom242424,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Text(
            "Luxe Essentials",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.primary),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "₦7,000 ",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: _customColor.custom242424,
                  ),
                ),
                TextSpan(
                  text: "₦10,000",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: _customColor.custom888888,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: _customColor.custom888888,
                    decorationThickness: 2.0,
                  ),
                ),
                const WidgetSpan(
                    child: SizedBox(
                  width: 8,
                )),
                WidgetSpan(
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: _customColor.customE7F84A,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Text(
                            "30% off",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: _customColor.custom242424),
                          ))),
                )
              ],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
          ),
          if (showRating)
            Row(children: [
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(5, (index) {
                    return Container(
                      margin: EdgeInsets.only(right: index + 1 == 5 ? 0 : 2),
                      child: Container(
                        alignment: Alignment.center,
                        height: 16,
                        width: 16,
                        child: Image.asset(
                            index < _noOfSelecteedRating
                                ? 'assets/icon/star.png'
                                : 'assets/icon/star_empty.png',
                            height: 16,
                            width: 16),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "(9 reviews)",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _customColor.custom3F1309),
              )
            ])
        ],
      ),
    );
  }
}
