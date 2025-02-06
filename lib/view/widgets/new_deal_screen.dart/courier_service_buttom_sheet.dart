import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_resource_controller.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class CourierServiceButtomSheet extends ConsumerStatefulWidget {
  const CourierServiceButtomSheet({super.key});

  @override
  ConsumerState<CourierServiceButtomSheet> createState() =>
      _CourierServiceButtomSheetState();
}

class _CourierServiceButtomSheetState
    extends ConsumerState<CourierServiceButtomSheet> {
  final CustomColors _customColor = const CustomColors();

  String? _courierServiceListErrorMessage;

  bool _courierServiceTypeListIsLoading = false;

  void _shippingRateCourierservice(
      {required String id,
      required String value,
      required String rate,
      required String estimatedDeliveryTime}) {
    ref.read(newDealDataProvider.notifier).updateNewDeal(
        "shippingRateCourierservice",
        CommonType(
          name: value,
          courierEstimatedTime: estimatedDeliveryTime,
          courierShippingRate: rate,
          id: id,
        ));

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _fetchCourierServices() async {
    setState(() {
      _courierServiceTypeListIsLoading = true;
      _courierServiceListErrorMessage = null;
    });

    try {
      await ref.read(appResourceProvider.notifier).fetchResources(
            type: DealsDropList.couriers.value,
          );
    } on CustomHttpException catch (error) {
      setState(() {
        _courierServiceListErrorMessage = error.toString();
      });
    } catch (error) {
      String errorMessage = error.toString();

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }

      print("errorrrrrrr $errorMessage");
      setState(() {
        _courierServiceListErrorMessage = errorMessage;
      });
    } finally {
      setState(() {
        _courierServiceTypeListIsLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appResourceData = ref.watch(appResourceProvider);

      if (appResourceData.fetchedCourierServices.isEmpty) {
        _fetchCourierServices();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final newDealData = ref.read(newDealDataProvider);

    final appResourceData = ref.watch(appResourceProvider);

    final mediaQuery = MediaQuery.of(context).size;

    final bottomSheetHeight = mediaQuery.height * 0.8;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: bottomSheetHeight,
        padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _customColor.custom6D6D6D,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Courier service",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Anybody",
                  color: _customColor.custom525252),
            ),
            NewDealBottomSheetList(
              showSearchField: true,
              hasSelected: newDealData.shippingRateCourierservice != null,
              dropdownItems: appResourceData.fetchedCourierServices,
              selectCourierService: _shippingRateCourierservice,
              selectedItem: newDealData.shippingRateCourierservice != null
                  ? newDealData.shippingRateCourierservice!.name.toString()
                  : "Choose an option",
              errorMessage: _courierServiceListErrorMessage,
              isLoading: _courierServiceTypeListIsLoading,
              retry: _fetchCourierServices,
            )
          ],
        ),
      ),
    );
  }
}
