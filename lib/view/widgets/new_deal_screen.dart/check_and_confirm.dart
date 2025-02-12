import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/check_and_confirm_card.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/preview_variant_card.dart';

class CheckAndConfirm extends ConsumerStatefulWidget {
  final VoidCallback editDetails;
  final Function confirm;
  const CheckAndConfirm({
    super.key,
    required this.editDetails,
    required this.confirm,
  });

  @override
  ConsumerState<CheckAndConfirm> createState() => _CheckAndConfirmState();
}

class _CheckAndConfirmState extends ConsumerState<CheckAndConfirm> {
  final CustomColors _customColor = const CustomColors();

  bool _showDetailsLocation = false;

  int _selectedIndex = -1;

  int _selectedVarient = -1;

  void _resizeVarient(int value) {
    setState(() {
      _selectedVarient = value == _selectedVarient ? -1 : value;
    });
  }

  Widget _buildDropDownHeader(
      {required int index,
      required String label,
      bool showDetailsLocation = false}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: _customColor.custom242424,
        ),
      ),
      AnimatedRotation(
        turns: _selectedIndex == index || showDetailsLocation ? 0.5 : 0,
        duration: const Duration(milliseconds: 300),
        child: Image.asset(
          "assets/icon/drop_down.png",
          height: 20,
          width: 20,
        ),
      ),
    ]);
  }

  Widget _buildShippingRegionCard({required String label}) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: _customColor.customE5F0F9,
          borderRadius: BorderRadius.circular(100)),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.end,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: _customColor.custom242424),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final newDealData = ref.watch(newDealDataProvider);

    final price = double.tryParse(newDealData.price.toString()) ?? 0.0;

    DateTime dateTime = DateTime.parse(newDealData.dealPromotionValidDate!);

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Text(
              "Check and confirm your entries before posting your promotion",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom242424),
            )),
        Column(children: [
          //Type
          Container(
            padding: const EdgeInsets.only(right: 16, left: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // Toggle accordion: If the same index is clicked, reset _selectedIndex
                      _selectedIndex = _selectedIndex == 0 ? -1 : 0;
                    });
                  },
                  child: Container(
                      height: 38,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildDropDownHeader(index: 0, label: "Type")),
                ),
                if (_selectedIndex == 0) const SizedBox(height: 10),
                if (_selectedIndex == 0)
                  CheckAndConfirmCard(
                    label: "I want to promote...",
                    value: newDealData.type!.name.toString(),
                  ),
                Divider(
                  color: _customColor.customEFEFEF,
                  thickness: 1,
                )
              ],
            ),
          ),

          //Details
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = _selectedIndex == 1 ? -1 : 1;
                        });
                      },
                      child: Container(
                          height: 38,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child:
                              _buildDropDownHeader(index: 1, label: "Details")),
                    )),
                if (_selectedIndex == 1) const SizedBox(height: 10),
                if (_selectedIndex == 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CheckAndConfirmCard(
                                  label: "Title",
                                  value: newDealData.title.toString(),
                                ),
                                CheckAndConfirmCard(
                                  label: "Category",
                                  value: newDealData.category.toString(),
                                ),
                                CheckAndConfirmCard(
                                  showBottomMargin: false,
                                  label: "Sub category",
                                  value: newDealData.subCategory.toString(),
                                ),
                                const SizedBox(height: 17),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 32),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (newDealData.type!.name ==
                                                dealTypeDropdownItems[1].name ||
                                            newDealData.type!.name ==
                                                dealTypeDropdownItems[2]
                                                    .name) ...[
                                          Text(
                                            "Images",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    theme.colorScheme.primary),
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: SizedBox(
                                                height: 88,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: newDealData
                                                                  .dealDetailsImages?[
                                                              0] !=
                                                          null
                                                      ? Image.file(
                                                          newDealData
                                                                  .dealDetailsImages![
                                                              0] as File,
                                                          height:
                                                              double.infinity,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover)
                                                      : const SizedBox.shrink(),
                                                ),
                                              )),
                                              Expanded(
                                                  child: SizedBox(
                                                height: 88,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: newDealData
                                                                  .dealDetailsImages?[
                                                              1] !=
                                                          null
                                                      ? Image.file(
                                                          newDealData
                                                                  .dealDetailsImages![
                                                              1] as File,
                                                          height:
                                                              double.infinity,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover)
                                                      : const SizedBox.shrink(),
                                                ),
                                              )),
                                              Expanded(
                                                  child: SizedBox(
                                                height: 88,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: newDealData
                                                                  .dealDetailsImages?[
                                                              2] !=
                                                          null
                                                      ? Image.file(
                                                          newDealData
                                                                  .dealDetailsImages![
                                                              2] as File,
                                                          height:
                                                              double.infinity,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover)
                                                      : const SizedBox.shrink(),
                                                ),
                                              )),
                                            ],
                                          ),
                                          Divider(
                                            color: _customColor.customEFEFEF,
                                            thickness: 1,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          )
                                        ],
                                      ]),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: theme.colorScheme.primary),
                                    )),
                                const SizedBox(height: 7),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      newDealData.description.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: _customColor.custom242424),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Divider(
                                      color: _customColor.customEFEFEF,
                                      thickness: 1,
                                    ))
                              ]),
                        ),

                        if (newDealData.varient.isNotEmpty &&
                            newDealData.type!.name ==
                                dealTypeDropdownItems[0].name)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 32),
                            child: Column(
                                children: newDealData.varient
                                    .asMap()
                                    .entries
                                    .map((entry) {
                              return PreviewVariantCard(
                                price: newDealData.price.toString(),
                                toggleVarient: _resizeVarient,
                                hasExpanded: _selectedVarient == entry.key + 1,
                                color: entry.value.color,
                                dimension: entry.value.dimension,
                                images: entry.value.images,
                                material: entry.value.material,
                                size: entry.value.size,
                                weight: entry.value.weight,
                                index: entry.key + 1,
                                key: ValueKey(entry.key),
                              );
                            }).toList()),
                          ),
                        const SizedBox(height: 7),

                        if (newDealData.type!.name ==
                            dealTypeDropdownItems[2].name)
                          Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Column(children: [
                                CheckAndConfirmCard(
                                  label: "Price",
                                  value:
                                      "₦${NumberFormat.decimalPattern().format(price)}",
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showDetailsLocation =
                                          !_showDetailsLocation;
                                    });
                                  },
                                  child: Container(
                                      height: 38,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: _buildDropDownHeader(
                                          index: -1,
                                          label: "Location",
                                          showDetailsLocation:
                                              _showDetailsLocation)),
                                ),
                                if (_showDetailsLocation)
                                  Column(children: [
                                    CheckAndConfirmCard(
                                      label: "Country",
                                      value: newDealData.spaceLocationCountry
                                          .toString(),
                                    ),
                                    CheckAndConfirmCard(
                                      label: "Address",
                                      value: newDealData.spaceLocationAddress
                                          .toString(),
                                    ),
                                    CheckAndConfirmCard(
                                      label: "City",
                                      value: newDealData.spaceLocationCity
                                          .toString(),
                                    ),
                                    CheckAndConfirmCard(
                                      label: "State",
                                      value: newDealData.spaceLocationState
                                          .toString(),
                                    ),
                                  ]),
                                CheckAndConfirmCard(
                                  label: "Capacity",
                                  value: newDealData.capacity.toString(),
                                ),
                                CheckAndConfirmCard(
                                  label: "Dimension",
                                  value: newDealData.dimension.toString(),
                                ),
                              ])),

                        if (newDealData.type!.name ==
                            dealTypeDropdownItems[1].name) ...[
                          CheckAndConfirmCard(
                            label: "Price",
                            value: !newDealData.contactForQuote
                                ? "Contact for quote"
                                : "₦${NumberFormat.decimalPattern().format(price)}",
                          ),
                          CheckAndConfirmCard(
                            label: "Duration",
                            value: newDealData.duration.toString(),
                          ),
                          CheckAndConfirmCard(
                            label: "No of rooms for cleaning",
                            value: newDealData.noOfRoomsForCleaning.toString(),
                          ),
                        ]
                        //
                        // const SizedBox(height: 4),
                        // CheckAndConfirmCard(
                        //     label: "Price/ Fee",
                        //     value: "Contact for quote",
                        //     theme: theme)
                      ],
                    ),
                  ),

                //PreviewVariantCard(index: 0),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      color: _customColor.customEFEFEF,
                      thickness: 1,
                    ))
              ],
            ),
          ),

          //Promotion
          Container(
            padding: const EdgeInsets.only(right: 16, left: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = _selectedIndex == 2 ? -1 : 2;
                    });
                  },
                  child: Container(
                      height: 38,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child:
                          _buildDropDownHeader(index: 2, label: "Promotion")),
                ),
                if (_selectedIndex == 2) const SizedBox(height: 10),
                if (_selectedIndex == 2)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckAndConfirmCard(
                          label: "Type",
                          value: newDealData.dealPromotionType.toString(),
                        ),
                        CheckAndConfirmCard(
                          label: "Value",
                          value: newDealData.dealPromotionValue.toString(),
                        ),
                        CheckAndConfirmCard(
                          label: "Code",
                          value: newDealData.dealPromotionCode.toString(),
                        ),
                        CheckAndConfirmCard(
                          label: "Valid till",
                          value: DateFormat("d MMMM, yyyy").format(dateTime),
                        ),
                      ]),
                Divider(
                  color: _customColor.customEFEFEF,
                  thickness: 1,
                )
              ],
            ),
          ),

          if (newDealData.type!.name == dealTypeDropdownItems[0].name)
            //Shipping info
            Container(
              padding: const EdgeInsets.only(bottom: 8, right: 16, left: 16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 7),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = _selectedIndex == 3 ? -1 : 3;
                      });
                    },
                    child: Container(
                        height: 38,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildDropDownHeader(
                            index: 3, label: "Shipping info")),
                  ),
                  if (_selectedIndex == 3) const SizedBox(height: 10),
                  if (_selectedIndex == 3)
                    CheckAndConfirmCard(
                      label: "Shipping from",
                      value: newDealData.shippingFromCountry.toString(),
                    ),
                  if (_selectedIndex == 3)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 37,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 1,
                          color: _customColor.customEFEFEF,
                        ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Shipping regions",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: theme.colorScheme.primary),
                            ),
                            const SizedBox(width: 20),
                            _buildShippingRegionCard(
                              label: newDealData.shippingToRegion.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Divider(
                    color: _customColor.customEFEFEF,
                    thickness: 1,
                  )
                ],
              ),
            ),
        ]),
        const SizedBox(height: 183),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                      onPressed: widget.editDetails,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(
                            color: theme.colorScheme.error, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        "Edit details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.error,
                        ),
                      )),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => widget.confirm(2),
                    style: TextButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
