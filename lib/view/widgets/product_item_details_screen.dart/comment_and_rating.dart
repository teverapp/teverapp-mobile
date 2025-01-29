import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class CommentAndRating extends StatelessWidget {
  const CommentAndRating({super.key});

  final CustomColors _customColor = const CustomColors();

  final List<String> _ratingPlaceHolder = const ["", "", "", ""];

  Widget buildRating({required int noOfSelecteedRating}) {
    return SizedBox(
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
                  index < noOfSelecteedRating
                      ? 'assets/icon/star.png'
                      : 'assets/icon/star_empty.png',
                  height: 16,
                  width: 16),
            ),
          );
        }),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
            children: _ratingPlaceHolder
                .map((value) => Container(
                      padding: const EdgeInsets.only(bottom: 24),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: _customColor.customEFEFEF))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRating(noOfSelecteedRating: 4),
                          const SizedBox(height: 16),
                          Text(
                            "Worth Every Penny!",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: _customColor.custom242424),
                          ),
                          const SizedBox(height: 16),
                          Text(
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _customColor.custom5D5D5D),
                              "This bag is worth every penny. The communication with the seller was excellent, and they made sure every detail was to my liking. The quality is exceptional, and I get compliments everywhere I go. Will definitely be ordering more from this shop."),
                          const SizedBox(height: 24),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: _customColor.custom93C6E6,
                                        shape: BoxShape.circle),
                                    child: Text(
                                      "VA",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: _customColor.custom242424),
                                    ),
                                  ),
                                ),
                                const WidgetSpan(
                                    child: SizedBox(
                                  width: 8,
                                )),
                                TextSpan(
                                  text: "Victoria Alli-Johnson ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: _customColor.custom242424,
                                  ),
                                ),
                                TextSpan(
                                  text: "January 12, 2024",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: _customColor.custom8939EE,
                                  ),
                                ),
                              ],
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList()),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: theme.primaryColor, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              "Load more",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.primaryColor,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
