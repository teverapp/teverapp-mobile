import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_resource_controller.dart';

import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/deals_tab.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/model/new_deal.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/new_deal_bottom_sheet_list.dart';

class TermsAndPolicyBottomSheet extends ConsumerStatefulWidget {
  const TermsAndPolicyBottomSheet({super.key});

  @override
  ConsumerState<TermsAndPolicyBottomSheet> createState() =>
      _TermsAndPolicyBottomSheetState();
}

class _TermsAndPolicyBottomSheetState
    extends ConsumerState<TermsAndPolicyBottomSheet> {
  final CustomColors _customColor = const CustomColors();

  String? _termsAndPolicyTypeListErrorMessage;

  bool _termsAndPolicyTypeListIsLoading = false;

  void _selectTermsAndPolicyFile(
      {required String value, required String id, String? imageUrl}) {
    final selectedFile = DocumentFile(title: value, content: "", id: id);

    ref
        .read(newDealDataProvider.notifier)
        .updateTermsAndPolicy(termsAndPolicy: selectedFile);

    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _fetchTermsAndPolicy() async {
    setState(() {
      _termsAndPolicyTypeListIsLoading = true;
      _termsAndPolicyTypeListErrorMessage = null;
    });

    try {
      await ref.read(appResourceProvider.notifier).fetchResources(
            type: DealsDropList.termsAndConditions.value,
          );
    } on CustomHttpException catch (error) {
      setState(() {
        _termsAndPolicyTypeListErrorMessage = error.toString();
      });
    } catch (error) {
      String errorMessage = error.toString();

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later. ";
      }

      setState(() {
        _termsAndPolicyTypeListErrorMessage = errorMessage;
      });
    } finally {
      setState(() {
        _termsAndPolicyTypeListIsLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appResourceData = ref.watch(appResourceProvider);

      if (appResourceData.termsAndCoditions.isEmpty) {
        _fetchTermsAndPolicy();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final newDealData = ref.read(newDealDataProvider);

    final appResourceData = ref.watch(appResourceProvider);

    final mediaQuery = MediaQuery.of(context).size;

    final height = mediaQuery.height * 0.66;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: height,
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
              "Terms & policies type",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Anybody",
                  color: _customColor.custom242424),
            ),
            const SizedBox(height: 14),
            NewDealBottomSheetList(
              hasSelected: true,
              hideBulletPoint: true,
              dropdownItems: appResourceData.termsAndCoditions,
              selectItem: _selectTermsAndPolicyFile,
              selectedItem: "",
              errorMessage: _termsAndPolicyTypeListErrorMessage,
              isLoading: _termsAndPolicyTypeListIsLoading,
              retry: _fetchTermsAndPolicy,
            )
          ],
        ),
      ),
    );
  }
}
