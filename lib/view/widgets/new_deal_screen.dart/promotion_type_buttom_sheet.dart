import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_resource_controller.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class PromotionTypeButtomSheet extends ConsumerStatefulWidget {
  const PromotionTypeButtomSheet({super.key});

  @override
  ConsumerState<PromotionTypeButtomSheet> createState() =>
      _PromotionTypeButtomSheetState();
}

class _PromotionTypeButtomSheetState
    extends ConsumerState<PromotionTypeButtomSheet> {
  final CustomColors _customColor = const CustomColors();

  String? _promotionTypeListErrorMessage;

  bool _promotionTypeListIsLoading = false;

  void _selectPromotionType(
      {required String value, required String id, String? imageUrl}) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("dealPromotionType", value);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _fetchPromotionType() async {
    setState(() {
      _promotionTypeListIsLoading = true;
      _promotionTypeListErrorMessage = null;
    });

    try {
      await ref.read(appResourceProvider.notifier).fetchResources(
            type: DealsDropList.promotionTypes.value,
          );
    } on CustomHttpException catch (error) {
      setState(() {
        _promotionTypeListErrorMessage = error.toString();
      });
    } catch (error) {
      String errorMessage = error.toString();

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }

      print("errorrrrrrr $errorMessage");
      setState(() {
        _promotionTypeListErrorMessage = errorMessage;
      });
    } finally {
      setState(() {
        _promotionTypeListIsLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appResourceData = ref.watch(appResourceProvider);

      if (appResourceData.fetchedPromotionTypes.isEmpty) {
        _fetchPromotionType();
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
              "Promotion Types",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Anybody",
                  color: _customColor.custom525252),
            ),
            NewDealBottomSheetList(
              showSearchField: true,
              hasSelected: newDealData.dealPromotionType != null,
              dropdownItems: appResourceData.fetchedPromotionTypes,
              selectItem: _selectPromotionType,
              selectedItem: newDealData.dealPromotionType != null
                  ? newDealData.dealPromotionType.toString()
                  : "Select promotion type",
              errorMessage: _promotionTypeListErrorMessage,
              isLoading: _promotionTypeListIsLoading,
              retry: _fetchPromotionType,
            )
          ],
        ),
      ),
    );
  }
}
