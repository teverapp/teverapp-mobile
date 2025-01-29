import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class Tickets extends StatelessWidget {
  const Tickets({super.key});

  final CustomColors _customColor = const CustomColors();

  Widget _buildCard({
    required String title,
    required String description,
    required String price,
    required String capacity,
    required bool showBottonBorder,
  }) {
    return Container(
        padding: EdgeInsets.only(bottom: showBottonBorder ? 23 : 0),
        margin: EdgeInsets.only(bottom: showBottonBorder ? 23 : 0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 1,
                color: showBottonBorder
                    ? _customColor.customDCDCDC
                    : Colors.transparent),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _customColor.custom6D6D6D),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 120,
              child: TextFormField(
                style: TextStyle(
                  color: _customColor.customB0B0B0,
                  fontSize: 14,
                ),
                maxLines: null,
                minLines: 5,
                initialValue: description,
                decoration: InputDecoration(
                  hintText: "Enter description",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(bottom: 16, right: 16),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(width: 1),
                  ),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _customColor.custom888888,
                  ),
                ),
                onChanged: (value) async {},
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Container(
                  height: 17.03,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          width: 1, color: _customColor.customDCDCDC),
                    ),
                  ),
                  padding: const EdgeInsets.only(right: 12),
                  margin: const EdgeInsets.only(right: 12),
                  child: Text(
                    "Price - ₦$price",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _customColor.custom5D5D5D),
                  ),
                ),
                Text(
                  "Capacity - $capacity",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _customColor.custom5D5D5D),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tickets",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _customColor.custom242424),
                ),
                Image.asset(
                  "assets/icon/edit.png",
                  height: 16,
                  width: 16,
                )
              ],
            ),
            const SizedBox(height: 13),
            _buildCard(
                title: "Regular Ticket",
                description:
                    "Gain access to the event venue and enjoy all the core activities, including keynote sessions, panel discussions, and networking opportunities. This ticket ensures you don't miss the main event highlights, providing an experience filled with inspiration, learning, and connections.",
                price: "15,000",
                capacity: "80",
                showBottonBorder: true),
            _buildCard(
                title: "Regular Ticket",
                description:
                    "Gain access to the event venue and enjoy all the core activities, including keynote sessions, panel discussions, and networking opportunities. This ticket ensures you don't miss the main event highlights, providing an experience filled with inspiration, learning, and connections.",
                price: "15,000",
                capacity: "80",
                showBottonBorder: false),

            // Divider(thickness: 1, color: _customColor.customDCDCDC)
          ],
        ));
  }
}
