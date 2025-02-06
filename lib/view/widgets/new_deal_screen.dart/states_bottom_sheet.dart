import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_resource_controller.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class StatesBottomSheet extends ConsumerStatefulWidget {
  final bool refetchCountry;
  final bool hideBulletPoints;
  final String selectedItem;
  final String countryId;
  final void Function(
      {required String value, required String id, String? imageUrl}) selectItem;
  const StatesBottomSheet({
    super.key,
    this.hideBulletPoints = true,
    required this.selectedItem,
    required this.selectItem,
    required this.countryId,
    this.refetchCountry = true,
  });

  @override
  ConsumerState<StatesBottomSheet> createState() => _StatesBottomSheetState();
}

class _StatesBottomSheetState extends ConsumerState<StatesBottomSheet> {
  final CustomColors _customColor = const CustomColors();

  String? _stateListErrorMessage;

  bool _stateListIsLoading = false;

  void _selectedStates(
      {required String value, required String id, String? imageUrl}) {
    widget.selectItem(id: id, value: value, imageUrl: imageUrl);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _fetchStateList({required String? id}) async {
    print("sttaed calllled");
    setState(() {
      _stateListErrorMessage = null;
      _stateListIsLoading = true;
    });

    try {
      await ref
          .read(appResourceProvider.notifier)
          .fetchResources(type: DealsDropList.state.value, id: id);
    } on CustomHttpException catch (error) {
      setState(() {
        _stateListErrorMessage = error.toString();
      });
    } catch (error) {
      String errorMessage = error.toString();

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }

      print("errorrrrrrr $errorMessage");
      setState(() {
        _stateListErrorMessage = errorMessage;
      });
    } finally {
      setState(() {
        _stateListIsLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appResourceData = ref.read(appResourceProvider);

      if (widget.refetchCountry) {
        _fetchStateList(id: widget.countryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appResourceData = ref.read(appResourceProvider);

    final newDealsData = ref.read(newDealDataProvider);

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
              "States",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Anybody",
                  color: _customColor.custom525252),
            ),
            NewDealBottomSheetList(
              showSearchField: true,
              hideBulletPoint: widget.hideBulletPoints,
              key: const Key("state"),
              hasSelected: false,
              dropdownItems: appResourceData.fetchedStates,
              selectItem: _selectedStates,
              selectedItem: widget.selectedItem,
              errorMessage: _stateListErrorMessage,
              isLoading: _stateListIsLoading,
              retry: () => _fetchStateList(id: widget.countryId),
            )
          ],
        ),
      ),
    );
  }
}
