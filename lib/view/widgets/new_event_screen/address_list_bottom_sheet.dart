import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tever/controller/app_resource_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/coordinate.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/model/predicted_places.dart';
import 'package:tever/view/widgets/general/common/logo_loader.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';

class AddressListButtomSheet extends ConsumerStatefulWidget {
  final String title;
  final String? intialSearchInput;
  final void Function({required Coordinate location}) selectLocation;
  const AddressListButtomSheet({
    super.key,
    required this.selectLocation,
    required this.title,
    this.intialSearchInput,
  });

  @override
  ConsumerState<AddressListButtomSheet> createState() =>
      _AddressListButtomSheetState();
}

class _AddressListButtomSheetState
    extends ConsumerState<AddressListButtomSheet> {
  final CustomColors _customColor = const CustomColors();

  final TextEditingController _searchController = TextEditingController();

  List<PredictedPlaces> placesPredictedList = [];

  bool _isLoading = false;

  void _showToast({required String message, required String status}) {
    if (mounted) {
      ToastService.showToast(
        context: context,
        message: message,
        status: status,
      );
    }
  }

  void _useMyCurrentLocation() {
    final userData = ref.watch(userDataProvider);

    widget.selectLocation(
      location: Coordinate(
        locationLatiude: userData.currentAddress?.locationLatiude,
        locationLongitude: userData.currentAddress?.locationLongitude,
        locationName: userData.currentAddress?.locationName,
      ),
    );

    if (mounted) {
      if (ModalRoute.of(context)?.isCurrent == true) {
        Navigator.of(context).pop();
      }
    }
  }

  _findPlaceAutoCompleteSearch(String inputText) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (inputText.isNotEmpty) {
        final placePredictionsList = await ref
            .read(appResourceProvider.notifier)
            .findPlaceAutoCompleteSearch(inputText);

        //placesPredictedList = placePredictionsList.take(7).toList();
        placesPredictedList = placePredictionsList.toList();
      }
    } on CustomHttpException catch (error) {
      _showToast(
        message: error.toString(),
        status: ToastStatus.error.name,
      );
    } catch (error) {
      String errorMessage = "Something went wrong!";

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later.";
      }

      _showToast(
        message: errorMessage,
        status: ToastStatus.error.name,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _findPlaceCoordinate(String placeId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (placeId.isNotEmpty) {
        final Coordinate coordinate = await ref
            .read(appResourceProvider.notifier)
            .findPlacesCoordinate(placeId);
        if (mounted) {
          if (ModalRoute.of(context)?.isCurrent == true) {
            Navigator.of(context).pop();
          }

          widget.selectLocation(location: coordinate);
        }
      }
    } on CustomHttpException catch (error) {
      _showToast(
        message: error.toString(),
        status: ToastStatus.error.name,
      );
    } catch (error) {
      String errorMessage = "Something went wrong!";

      if (error is SocketException || error is HandshakeException) {
        errorMessage = "Network error, Please try again later.";
      }

      _showToast(
        message: errorMessage,
        status: ToastStatus.error.name,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildPredictedPlacedCard(
      {required String title,
      required String subTitle,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 61,
        padding: const EdgeInsets.only(top: 7),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: _customColor.customEFEFEF,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 3),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _customColor.custom5D5D5D,
                  BlendMode.srcATop,
                ),
                child: Image.asset(
                  "assets/icon/location_gray.png",
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom5D5D5D),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    subTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom5D5D5D),
                  ),
                ]))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.intialSearchInput != null) {
        _searchController.text = widget.intialSearchInput!;

        _findPlaceAutoCompleteSearch(widget.intialSearchInput!);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final theme = Theme.of(context);

    final height = mediaQuery.height * 0.9;

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
            const SizedBox(height: 26),
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _customColor.custom525252,
                  fontFamily: "Anybody"),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _searchController,
              style: TextStyle(
                color: _customColor.custom242424,
                fontSize: 14,
              ),
              autofocus: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(16),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: 1,
                  ),
                ),
                prefixIconConstraints:
                    const BoxConstraints(maxHeight: 150, maxWidth: 150),
                prefixIcon: Container(
                  margin: const EdgeInsets.only(left: 16, right: 8),
                  child: Image.asset(
                    "assets/icon/location_orange.png",
                    height: 16,
                    width: 16,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.primaryColor,
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
              onChanged: (value) {
                _findPlaceAutoCompleteSearch(value);
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _useMyCurrentLocation,
              child: Container(
                height: 36,
                width: 197,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: _customColor.customE5F0F9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        _customColor.custom292D32,
                        BlendMode.srcATop,
                      ),
                      child: Image.asset(
                        "assets/icon/sent.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Use my current location",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _customColor.custom242424,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 7),
            Divider(
              color: _customColor.customEFEFEF,
              thickness: 1,
            ),
            const SizedBox(height: 12),
            if (_isLoading)
              const Align(
                alignment: Alignment.topCenter,
                child: const LogoLoader(height: 20, width: 20),
              ),
            if (!_isLoading)
              Expanded(
                child: ListView.builder(
                  itemCount: placesPredictedList.length,
                  itemBuilder: (_, index) {
                    return _buildPredictedPlacedCard(
                      onTap: () => _findPlaceCoordinate(
                          placesPredictedList[index].placeId.toString()),
                      title: placesPredictedList[index].mainText.toString(),
                      subTitle:
                          placesPredictedList[index].secondaryText.toString(),
                    );

                    // WhereToGo(
                    //   onPress: () {
                    //     _updateLocation(
                    //         placesPredictedList[index].placeId.toString());
                    //   },
                    //   key: ValueKey(
                    //       placesPredictedList[index].placeId.toString()),
                    //   icon: randomIcon,
                    //   title: placesPredictedList[index].mainText.toString(),
                    //   subTitle: placesPredictedList[index]
                    //       .secondaryText
                    //       .toString(),
                    // );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
