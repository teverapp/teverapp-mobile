import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/general/common/custom_drop_down.dart';
import 'package:tever/view/widgets/general/common/custom_input_selection_button.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/courier_service_buttom_sheet.dart';

class AddShipingRateCard extends ConsumerStatefulWidget {
  const AddShipingRateCard({super.key});

  @override
  ConsumerState<AddShipingRateCard> createState() => _AddShipingRateCardState();
}

class _AddShipingRateCardState extends ConsumerState<AddShipingRateCard> {
  final CustomColors _customColor = const CustomColors();

  final TextEditingController _rateController = TextEditingController();

  final TextEditingController _estimatedDeliveryTimeController =
      TextEditingController();

  // void _shippingRateCourierservice(
  //     {required String value, required String id, String? imageUrl}) {
  //   ref
  //       .read(newDealDataProvider.notifier)
  //       .updateNewDeal("shippingRateCourierservice", value);
  // }

  void _showToast({required String message, required String status}) {
    if (mounted) {
      ToastService.showToast(
        context: context,
        message: message,
        status: status,
      );
    }
  }

  _validateCourierService({String? rate}) {
    final newDealData = ref.watch(newDealDataProvider);

    if (newDealData.shippingRateCourierservice?.id == null) {
      _showToast(
        message: "Please select courier service!",
        status: ToastStatus.error.name,
      );
    } else {
      if (rate != null) {
        ref.read(newDealDataProvider.notifier).updateCourierServiceRate(rate);
      } else {
        _showCourierServiceBottomSheet();
      }
    }
  }

  void _showCourierServiceBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const CourierServiceButtomSheet();
      },
    );
  }

  void _hideCard() {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("showShippingRateCard", false);

    print("calleddddd");
    ref.read(newDealDataProvider.notifier).updateNewDeal(
        "shippingRateCourierservice",
        NewDeal.defaultState().shippingRateCourierservice);

    // ref
    //     .read(newDealDataProvider.notifier)
    //     .updateNewDeal("shippingRateEstimatedDeliveryTime", "");

    // ref.read(newDealDataProvider.notifier).updateNewDeal("shippingRate", "");
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final newDealData = ref.watch(newDealDataProvider);

  //     _rateController.text = newDealData.shippingRate ?? "";
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _rateController.dispose();

    _estimatedDeliveryTimeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newDealData = ref.watch(newDealDataProvider);

    _rateController.text = newDealData.shippingRateCourierservice?.id != null
        ? newDealData.shippingRateCourierservice!.courierShippingRate.toString()
        : "";

    _estimatedDeliveryTimeController.text =
        newDealData.shippingRateCourierservice?.id != null
            ? newDealData.shippingRateCourierservice!.courierEstimatedTime
                .toString()
            : "";

    print("calleddddd build ${_rateController.text}");

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping rate",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom2E3438),
              ),
              GestureDetector(
                onTap: _hideCard,
                child: Image.asset(
                  "assets/icon/close-circle_red.png",
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Courier service",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 9),
          CustomInputSelectionButton(
            hasSelected: newDealData.shippingRateCourierservice?.id != null,
            onTap: _showCourierServiceBottomSheet,
            selectedItem: newDealData.shippingRateCourierservice?.id != null
                ? newDealData.shippingRateCourierservice!.name.toString()
                : "Choose an option",
          ),
          // CustomDropDown(
          //   hasSelected: newDealData.shippingRateCourierservice != null,
          //   dropdownItems: newDealData.countries,
          //   selectItem: _shippingRateCourierservice,
          //   selectedItem: newDealData.shippingRateCourierservice != null
          //       ? newDealData.shippingRateCourierservice.toString()
          //       : "Choose an option",
          // ),
          const SizedBox(height: 16),
          Text(
            "Rate",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 9),
          TextField(
            readOnly: newDealData.shippingRateCourierservice?.id == null,
            controller: _rateController,
            style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: "Enter rate",
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(left: 16, bottom: 1),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
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
            onTap: () => _validateCourierService(
              rate: newDealData.shippingRateCourierservice?.courierShippingRate,
            ),
            onChanged: (value) =>
                _validateCourierService(rate: value.isEmpty ? null : value),
          ),
          const SizedBox(height: 16),
          Text(
            "Estimated delivery time",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _customColor.custom242424),
          ),
          const SizedBox(height: 9),

          TextField(
            readOnly: true,
            controller: _estimatedDeliveryTimeController,
            style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: "Select estimated delivery time",
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(left: 16, bottom: 1),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
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
            onTap: () => _validateCourierService(),
          ),
          // CustomDropDown(
          //   hasSelected: newDealData.shippingRateEstimatedDeliveryTime != null,
          //   dropdownItems: newDealData.countries,
          //   selectItem: _estimatedDdeliveryTimeHandler,
          //   selectedItem: newDealData.shippingRateEstimatedDeliveryTime != null
          //       ? newDealData.shippingRateEstimatedDeliveryTime.toString()
          //       : "Select estimated delivery time",
          // ),
          // Text(
          //   "Nigeria (Nationwide delivery)",
          //   style: TextStyle(
          //       fontSize: 12,
          //       fontWeight: FontWeight.w400,
          //       color: _customColor.custom242424),
          // ),
          // const SizedBox(height: 16),
          // Divider(
          //   color: _customColor.customEFEFEF,
          //   thickness: 1,
          // ),
          // const SizedBox(height: 16),
          // Text(
          //   "Shipping rate",
          //   style: TextStyle(
          //       fontSize: 12,
          //       fontWeight: FontWeight.w500,
          //       color: _customColor.custom242424),
          // ),
          // const SizedBox(height: 9),
          // TextFormField(
          //   style: TextStyle(
          //     color: _customColor.custom242424,
          //     fontSize: 14,
          //   ),
          //   decoration: InputDecoration(
          //     hintText: "₦0",
          //     filled: true,
          //     fillColor: Colors.white,
          //     contentPadding: const EdgeInsets.all(16),
          //     focusedBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: BorderSide(
          //         color: _customColor.customEFEFEF,
          //         width: 1,
          //       ),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: BorderSide(
          //         color: _customColor.customEFEFEF,
          //         width: 1,
          //       ),
          //     ),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: BorderSide(
          //         color: _customColor.customEFEFEF,
          //         width: 1,
          //       ),
          //     ),
          //     errorBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: const BorderSide(width: 1),
          //     ),
          //     hintStyle: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w400,
          //       color: _customColor.custom888888,
          //     ),
          //   ),
          //   onChanged: (value) async {},
          // ),
          // const SizedBox(height: 16),
          // Text(
          //   "Estimated delivery time",
          //   style: TextStyle(
          //       fontSize: 12,
          //       fontWeight: FontWeight.w500,
          //       color: _customColor.custom242424),
          // ),
          // const SizedBox(height: 9),
          // TextFormField(
          //   style: TextStyle(
          //     color: _customColor.custom242424,
          //     fontSize: 14,
          //   ),
          //   decoration: InputDecoration(
          //     hintText: "Choose an option",
          //     filled: true,
          //     fillColor: Colors.white,
          //     contentPadding: const EdgeInsets.all(16),
          //     focusedBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: BorderSide(
          //         color: _customColor.customEFEFEF,
          //         width: 1,
          //       ),
          //     ),
          //     suffixIconConstraints:
          //         const BoxConstraints(maxHeight: 150, maxWidth: 150),
          //     suffixIcon: Container(
          //       margin: const EdgeInsets.only(right: 16),
          //       child: Image.asset(
          //         "assets/icon/drop_down.png",
          //         height: 16,
          //         width: 16,
          //       ),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: BorderSide(
          //         color: _customColor.customEFEFEF,
          //         width: 1,
          //       ),
          //     ),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: BorderSide(
          //         color: _customColor.customEFEFEF,
          //         width: 1,
          //       ),
          //     ),
          //     errorBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: const BorderSide(width: 1),
          //     ),
          //     hintStyle: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w400,
          //       color: _customColor.custom888888,
          //     ),
          //   ),
          //   onChanged: (value) async {},
          // ),
        ],
      ),
    );
  }
}
