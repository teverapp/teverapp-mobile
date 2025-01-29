import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/screens/error_screen.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/screens/waiting_screen.dart';
import 'package:tever/view/tabs/deals_tab.dart';
import 'package:tever/view/tabs/home_tab.dart';
import 'package:tever/view/tabs/more_tab.dart';
import 'package:tever/view/tabs/orders_tab.dart';

class TabsScreen extends ConsumerStatefulWidget {
  final int? selectedPageIndex;
  final bool justCreatedBusnessProfile;
  const TabsScreen(
      {super.key,
      this.selectedPageIndex,
      this.justCreatedBusnessProfile = false});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  late final List<Widget> _pages;

  Future<void>? _allUserDataFuture;

  bool _fetchedInitialData = false;

  final CustomColors _customColor = const CustomColors();
  final List<String> navIcons = ['home', 'deals', 'add', 'orders', 'more'];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _retryFetchingUserData() {
    setState(() {
      _allUserDataFuture = _obtainUserDataFuture();
    });
  }

  Future<void> _obtainUserDataFuture() async {
    await _handleLocationPermission();

    final authIfo = ref.read(authProvider);
    if (!authIfo.isGuest) {
      await ref.read(userDataProvider.notifier).fetchUserData();
    }
    await _getCurrentLocation();

    return Future.value();
  }

  void _fetchInitialData() async {
    final userData = ref.read(userDataProvider);

    if (userData.firstName != null) {
      _allUserDataFuture = Future.value();
    } else {
      _allUserDataFuture = _obtainUserDataFuture();
    }
  }

  void _navigateToSignInScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  Future<void> _handleLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw CustomHttpException("00");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw CustomHttpException("00");
    }

    return;
  }

  // Get current location
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks[0];

    print(
        " -->> ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}");
    final currentAddress =
        "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";

    ref
        .read(userDataProvider.notifier)
        .updateField("latitude", position.latitude.toString());
    ref
        .read(userDataProvider.notifier)
        .updateField("longitude", position.longitude.toString());

    ref
        .read(userDataProvider.notifier)
        .updateField("currentAddress", currentAddress);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_fetchedInitialData) {
      _fetchInitialData();
      _fetchedInitialData = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeTab(justCreatedBusnessProfile: widget.justCreatedBusnessProfile),
      const DealsTab(),
      const SizedBox.shrink(),
      const OrdersTab(),
      const MoreTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final body = IndexedStack(
      index: _selectedPageIndex,
      children: _pages,
    );

    return FutureBuilder(
        future: _allUserDataFuture,
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const WaitingScreen(title: "Please wait...");
          } else if (dataSnapShot.hasError) {
            String errorMessage = dataSnapShot.error.toString();

            print("errorMessage ===> $errorMessage");

            if (errorMessage == "401") {
              //Ensures the callback executes after the current frame completes.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _navigateToSignInScreen();
              });

              return ErrorScreen(
                isNetworkError: false,
                retry: _retryFetchingUserData,
              );
            } else if (errorMessage == "00" ||
                dataSnapShot.error is PermissionDeniedException) {
              return ErrorScreen(
                  errorMessage:
                      "Tever needs access to your device location to function properly. Please go to your device's settings to enable location services for Tever then try again.",
                  retry: _retryFetchingUserData,
                  isNetworkError: false);
            } else if (dataSnapShot.error is SocketException ||
                dataSnapShot.error is HandshakeException) {
              return ErrorScreen(
                  isNetworkError: true, retry: _retryFetchingUserData);
            } else {
              return ErrorScreen(
                  isNetworkError: false, retry: _retryFetchingUserData);
            }
          }

          return Scaffold(
            body: _selectedPageIndex == 4
                ? body
                : SafeArea(
                    child: body,
                  ),
            bottomNavigationBar: Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color:
                        _customColor.custom033DCDCDC, // Semi-transparent gray
                    offset: const Offset(0, -4), // Horizontal: 0, Vertical: -4
                    blurRadius: 8, // Blur radius of 8
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: navIcons.asMap().entries.map((entry) {
                  final isMiddleItem = entry.key == 2;
                  final isSelected = _selectedPageIndex == entry.key;

                  return GestureDetector(
                    onTap: () => _selectPage(entry.key),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isMiddleItem)
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.only(bottom: 4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              "assets/icon/add.png",
                              height: 20,
                              width: 20,
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                'assets/icon/${entry.value}_${isSelected ? 'active' : 'inactive'}.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        if (!isMiddleItem)
                          Text(
                            entry.value[0].toUpperCase() +
                                entry.value.substring(1),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? theme.primaryColor
                                  : _customColor.customBDBDBD,
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}
