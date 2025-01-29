import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class SuccessStoriesSection extends StatelessWidget {
  const SuccessStoriesSection({super.key});

  final CustomColors _customColor = const CustomColors();

  Widget _buildSuccessStoriesCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 1,
          color: _customColor.customEFEFEF,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _customColor.customC6E0F1),
                    child: Text(
                      "JD",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: _customColor.custom242424,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "John Doe",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: _customColor.custom292929,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Student",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _customColor.custom989898,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Text(
                "Nov 29, 2024",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom989898,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "I started sharing my referral link with friends, thinking it wouldn't make much of a difference. Within weeks, I earned enough to cover half of my tuition fees. The program has practically been a lifesaver!",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: _customColor.custom464646),
          ),
          const SizedBox(height: 23),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border:
                        Border.all(width: 1, color: _customColor.customDCDCDC)),
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/icon/love.png",
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "0",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom989898,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border:
                        Border.all(width: 1, color: _customColor.customDCDCDC)),
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/icon/like_darker.png",
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "0",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom989898,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border:
                        Border.all(width: 1, color: _customColor.customDCDCDC)),
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/icon/fire.png",
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "0",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom989898,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //for empty state => SuccessStoriesEmptyState();
    return Column(
      children: [_buildSuccessStoriesCard()],
    );
  }
}
