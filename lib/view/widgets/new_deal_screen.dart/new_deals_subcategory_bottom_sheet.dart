import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class NewDealsSubcategoryBottomSheet extends ConsumerStatefulWidget {
  const NewDealsSubcategoryBottomSheet({super.key});

  @override
  ConsumerState<NewDealsSubcategoryBottomSheet> createState() =>
      _NewDealsSubcategoryBottomSheetState();
}

class _NewDealsSubcategoryBottomSheetState
    extends ConsumerState<NewDealsSubcategoryBottomSheet> {
  final CustomColors _customColor = const CustomColors();

  String? _dealSubCategoryListErrorMessage;

  bool _dealSubCategoryListIsLoading = false;

  void _selectSubCategory(
      {required String value, required String id, String? imageUrl}) {
    ref.read(newDealDataProvider.notifier).updateNewDeal("subCategoryId", id);

    ref.read(newDealDataProvider.notifier).updateNewDeal("subCategory", value);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _fetchDealSubCategoryList() async {
    setState(() {
      _dealSubCategoryListIsLoading = true;
      _dealSubCategoryListErrorMessage = null;
    });

    try {
      await ref.read(newDealDataProvider.notifier).fetchResources(
          type: DealsDropList.dealSubcategories.value, fetchItemWithId: true);
    } on CustomHttpException catch (error) {
      setState(() {
        _dealSubCategoryListErrorMessage = error.toString();
      });
    } catch (error) {
      String errorMessage = error.toString();

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }

      print("errorrrrrrr $errorMessage");
      setState(() {
        _dealSubCategoryListErrorMessage = errorMessage;
      });
    } finally {
      setState(() {
        _dealSubCategoryListIsLoading = false;
      });
    }
  }

  void _addMoreItemsToSUbCat(CommonType value) {
    ref.read(newDealDataProvider.notifier).addToSubCategoryList(subCat: value);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newDealData = ref.watch(newDealDataProvider);

      if (newDealData.dealDetailsSubCategory.isEmpty) {
        _fetchDealSubCategoryList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final newDealData = ref.watch(newDealDataProvider);

    final mediaQuery = MediaQuery.of(context).size;

    final bottomSheetHeight = mediaQuery.height * 0.85;

    print("sub rebuilt");

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
              "${newDealData.category} subcategory",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Anybody",
                  color: _customColor.custom525252),
            ),
            NewDealBottomSheetList(
              useNullAsAddedItemId: true,
              showSearchField: true,
              addMoreItemsToList: _addMoreItemsToSUbCat,
              hasSelected: newDealData.subCategoryId != null,
              dropdownItems: newDealData.dealDetailsSubCategory,
              selectItem: _selectSubCategory,
              selectedItem: newDealData.subCategoryId != null
                  ? newDealData.subCategory.toString()
                  : "Select sub category",
              errorMessage: _dealSubCategoryListErrorMessage,
              isLoading: _dealSubCategoryListIsLoading,
              retry: _fetchDealSubCategoryList,
            )
          ],
        ),
      ),
    );
  }
}
