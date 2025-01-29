import 'package:flutter/material.dart';
import 'package:tever/controller/input_validation_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_deal.dart';

class LocationSelectionList extends StatefulWidget {
  final String label;
  final Function remove;
  final bool? flagIsAvailabe;
  final List<LocationSelection> listItem;
  const LocationSelectionList({
    super.key,
    required this.label,
    required this.listItem,
    required this.remove,
    this.flagIsAvailabe = false,
  });

  @override
  State<LocationSelectionList> createState() => _LocationSelectionListState();
}

class _LocationSelectionListState extends State<LocationSelectionList> {
  final CustomColors _customColor = const CustomColors();

  bool _showFullList = false;

  final InputValidationController _validate = InputValidationController();

  @override
  Widget build(BuildContext context) {
    final displayedItems =
        _showFullList ? widget.listItem : widget.listItem.take(9).toList();

    final remainingCount = widget.listItem.length - displayedItems.length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.label.toUpperCase()} INCLUDES",
            style: TextStyle(
              color: _customColor.custom888888,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: displayedItems
                .asMap()
                .entries
                .map((entry) => GestureDetector(
                      onTap: () => widget.remove(entry.key),
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: _customColor.customF6F6F6,
                            borderRadius: BorderRadius.circular(100)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_validate
                                .isImageUrl(entry.value.flag.toString())) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.network(
                                      entry.value.flag.toString(),
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                            ],
                            Text(
                              entry.value.name.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: _customColor.custom242424,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Image.asset(
                              "assets/icon/close_slim.png",
                              height: 16,
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          if (widget.listItem.length > 9) ...[
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showFullList = !_showFullList;
                });
              },
              child: SizedBox(
                height: 26,
                child: Text(
                  _showFullList ? "Show less" : "+$remainingCount more",
                  style: TextStyle(
                    fontSize: 14,
                    color: _customColor.customFF5349,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
