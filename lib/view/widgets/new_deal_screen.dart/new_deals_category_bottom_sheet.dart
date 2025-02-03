import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_resource_controller.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class NewDealsCategoryBottomSheet extends ConsumerStatefulWidget {
  const NewDealsCategoryBottomSheet({super.key});

  @override
  ConsumerState<NewDealsCategoryBottomSheet> createState() =>
      _NewDealsCategoryBottomSheetState();
}

class _NewDealsCategoryBottomSheetState
    extends ConsumerState<NewDealsCategoryBottomSheet> {
  final CustomColors _customColor = const CustomColors();

  String? _dealCategoryListErrorMessage;

  bool _dealCategoryListIsLoading = false;

  void _selectCategory(
      {required String value, required String id, String? imageUrl}) {
    ref.read(newDealDataProvider.notifier).updateNewDeal("categoryId", id);

    ref.read(newDealDataProvider.notifier).updateNewDeal("category", value);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _fetchDealCategoryList() async {
    print("_fetchDealCategoryList called");
    setState(() {
      _dealCategoryListIsLoading = true;
      _dealCategoryListErrorMessage = null;
    });

    try {
      await ref
          .read(appResourceProvider.notifier)
          .fetchResources(type: DealsDropList.dealCategories.value);
    } on CustomHttpException catch (error) {
      setState(() {
        _dealCategoryListErrorMessage = error.toString();
      });
    } catch (error) {
      String errorMessage = error.toString();

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }

      print("errorrrrrrr $errorMessage");
      setState(() {
        _dealCategoryListErrorMessage = errorMessage;
      });
    } finally {
      setState(() {
        _dealCategoryListIsLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appResourceData = ref.watch(appResourceProvider);

      if (appResourceData.fetchedDealDetailsCategory.isEmpty) {
        _fetchDealCategoryList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final newDealData = ref.read(newDealDataProvider);

    final appResourceData = ref.read(appResourceProvider);

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
              "Item category",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Anybody",
                  color: _customColor.custom525252),
            ),
            NewDealBottomSheetList(
              showSearchField: true,
              hasSelected: newDealData.categoryId != null,
              dropdownItems: appResourceData.fetchedDealDetailsCategory,
              selectItem: _selectCategory,
              selectedItem: newDealData.categoryId != null
                  ? newDealData.category.toString()
                  : "Select Category",
              errorMessage: _dealCategoryListErrorMessage,
              isLoading: _dealCategoryListIsLoading,
              retry: _fetchDealCategoryList,
            )
          ],
        ),
      ),
    );
  }
}
