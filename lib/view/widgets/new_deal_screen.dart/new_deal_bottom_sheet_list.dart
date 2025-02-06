import 'package:flutter/material.dart';

import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/view/widgets/general/common/logo_loader.dart';

class NewDealBottomSheetList extends StatefulWidget {
  final List<CommonType> dropdownItems;
  final bool? useNullAsAddedItemId;
  final bool showSearchField;
  final Function? addMoreItemsToList;
  final void Function(
      {required String value,
      required String id,
      String? imageUrl})? selectItem;
  final void Function(
      {required String id,
      required String value,
      required String rate,
      required String estimatedDeliveryTime})? selectCourierService;
  final String selectedItem;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? retry;
  final bool hasSelected;
  final bool? hideBulletPoint;
  const NewDealBottomSheetList({
    super.key,
    required this.dropdownItems,
    this.selectItem,
    required this.selectedItem,
    required this.hasSelected,
    this.isLoading = false,
    this.addMoreItemsToList,
    this.errorMessage,
    this.retry,
    this.hideBulletPoint = false,
    this.showSearchField = false,
    this.useNullAsAddedItemId,
    this.selectCourierService,
  });

  @override
  State<NewDealBottomSheetList> createState() => _NewDealBottomSheetListState();
}

class _NewDealBottomSheetListState extends State<NewDealBottomSheetList> {
  final CustomColors _customColor = const CustomColors();

  String _searchQuery = "";

  bool _startAddingNewItemToList = false;

  final TextEditingController _addMoreItemsToListController =
      TextEditingController();

  void _showStartAddingNewItemToListHandler() {
    setState(() {
      _startAddingNewItemToList = true;
    });
  }

  final ScrollController _addMoretemsToListController = ScrollController();

  void _scrollToBottom() {
    _addMoretemsToListController.animateTo(
      _addMoretemsToListController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Widget _buildErrorContent(
      {required ThemeData theme, required String errorMessage}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Text(
                errorMessage,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 30,
              width: 90,
              child: TextButton(
                onPressed: widget.retry,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  "Try again",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _addMoretemsToListController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final mediaQuery = MediaQuery.of(context).size;

    final addHeightToScrollAddItemButton = mediaQuery.height * 0.45;

    final filteredropdownItems = widget.dropdownItems.where((item) {
      return item.name.toLowerCase().startsWith(_searchQuery.toLowerCase());
    }).toList();

    print("sub cat build called");
    return Expanded(
        child: Column(children: [
      if (widget.showSearchField) const SizedBox(height: 10),
      if (widget.showSearchField)
        SizedBox(
          height: 32,
          child: TextField(
            autocorrect: true,
            enableSuggestions: true,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: _customColor.custom242424,
              fontSize: 14,
            ),
            cursorHeight: 16,
            decoration: InputDecoration(
              hintText: "Start typing...",
              filled: true,
              fillColor: _customColor.customFAFAFA,
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 50,
                maxWidth: 150,
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.only(left: 16, right: 8),
                child: Image.asset(
                  "assets/icon/search_light_gray.png",
                  height: 16,
                  width: 16,
                ),
              ),
              contentPadding: const EdgeInsets.only(bottom: 12),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom888888,
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
      if (widget.showSearchField) const SizedBox(height: 10),
      Expanded(
        child: widget.isLoading
            ? const LogoLoader(height: 40, width: 40)
            : widget.errorMessage != null
                ? _buildErrorContent(
                    theme: theme, errorMessage: widget.errorMessage!)
                : filteredropdownItems.isEmpty
                    ? const Center(
                        child: Text(
                          "No item found",
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        //shrinkWrap: true,
                        controller: _addMoretemsToListController,
                        padding: EdgeInsets.zero,
                        itemCount: filteredropdownItems.length,
                        itemBuilder: (context, index) {
                          final isActive = filteredropdownItems[index].name ==
                              widget.selectedItem;

                          return Column(children: [
                            GestureDetector(
                              onTap: () {
                                if (widget.selectCourierService != null) {
                                  widget.selectCourierService!(
                                      id: filteredropdownItems[index].id!,
                                      value: filteredropdownItems[index].name,
                                      rate: filteredropdownItems[index]
                                          .courierShippingRate
                                          .toString(),
                                      estimatedDeliveryTime:
                                          filteredropdownItems[index]
                                              .courierEstimatedTime
                                              .toString());
                                } else if (widget.selectItem != null) {
                                  widget.selectItem!(
                                      value: filteredropdownItems[index].name,
                                      id: filteredropdownItems[index]
                                          .id
                                          .toString(),
                                      imageUrl:
                                          filteredropdownItems[index].imageUrl);
                                }
                              },
                              child: Container(
                                height: 32,
                                width: double.infinity,
                                color: Colors.transparent,
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    if (!widget.hideBulletPoint!) ...[
                                      Image.asset(
                                        isActive
                                            ? "assets/icon/radio_active_circular.png"
                                            : "assets/icon/radio_inactive_circular.png",
                                        height: 16,
                                        width: 16,
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                    Text(
                                      filteredropdownItems[index]
                                          .name
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _customColor.custom242424,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (widget.addMoreItemsToList != null &&
                                (filteredropdownItems.isEmpty ||
                                    filteredropdownItems.length - 1 ==
                                        index)) ...[
                              if (!_startAddingNewItemToList)
                                SizedBox(
                                    height: 38,
                                    child: GestureDetector(
                                      onTap:
                                          _showStartAddingNewItemToListHandler,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/icon/add_circle_orange.png",
                                            height: 16,
                                            width: 16,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "Add new",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: _customColor.customE1781F,
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              if (_startAddingNewItemToList)
                                SizedBox(
                                  height: 48,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: _customColor.customDCDCDC,
                                            ),
                                          ),
                                        ),
                                        child: TextField(
                                          onTap: _scrollToBottom,
                                          controller:
                                              _addMoreItemsToListController,
                                          style: TextStyle(
                                            color: _customColor.custom242424,
                                            fontSize: 14,
                                            height: 1.4,
                                          ),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            isDense:
                                                true, // Reduces padding around the text
                                            hintText: "Enter text",
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 2,
                                              horizontal: 4,
                                            ),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            border: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: _customColor.custom888888,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            print("valeeee");
                                            if (_addMoreItemsToListController
                                                .text.isEmpty) return;

                                            String? result;

                                            if (widget.useNullAsAddedItemId !=
                                                null) {
                                              final String? stringId =
                                                  widget.dropdownItems.last.id;

                                              int numberId = int.parse(
                                                      stringId.toString()) +
                                                  1;

                                              result = numberId.toString();
                                            }

                                            widget.addMoreItemsToList!(CommonType(
                                                id: result,
                                                name:
                                                    _addMoreItemsToListController
                                                        .text));

                                            _addMoreItemsToListController
                                                .clear();

                                            _scrollToBottom();
                                          },
                                          child: Image.asset(
                                            "assets/icon/tick_circle.png",
                                            height: 16,
                                            width: 16,
                                          ))
                                    ],
                                  ),
                                ),
                              SizedBox(height: addHeightToScrollAddItemButton)
                            ],
                          ]);
                        },
                      ),
      ),
    ]));
  }
}
