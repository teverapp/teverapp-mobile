import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/posted_deals.dart';
import 'package:tever/view/screens/error_screen.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/screens/waiting_screen.dart';

import 'package:tever/view/widgets/general/common/posted_card.dart';
import 'package:tever/view/widgets/hot_deals_screen/posted_deals_bottom_sheet.dart';

class PostedDeals extends ConsumerStatefulWidget {
  const PostedDeals({super.key});

  @override
  ConsumerState<PostedDeals> createState() => _PostedDealsState();
}

class _PostedDealsState extends ConsumerState<PostedDeals> {
  Future<void>? _allUserDataFuture;

  bool _fetchedInitialData = false;

  void _navigateToSignInScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  Future<void> _obtainUserDataFuture() async {
    return ref.read(postedDealsProvider.notifier).fetchPostedDeals();
  }

  void _retryFetchingUserData() {
    setState(() {
      _allUserDataFuture = _obtainUserDataFuture();
    });
  }

  void _fetchInitialData() async {
    // final userData = ref.read(userDataProvider);

    // if (userData.firstName != null) {
    //   _allUserDataFuture = Future.value();
    // } else {
    //   _allUserDataFuture = _obtainUserDataFuture();
    // }
    _allUserDataFuture = _obtainUserDataFuture();
  }

  void _showPostedDealsBottomSheet(String id) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return PostedDealsBottomSheet(id: id);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final postedDeals = ref.watch(postedDealsProvider);

    if (!_fetchedInitialData && postedDeals.isEmpty) {
      _fetchInitialData();
      _fetchedInitialData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final postedDeals = ref.watch(postedDealsProvider);

    return FutureBuilder(
        future: _allUserDataFuture,
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const WaitingScreen(
                hideScaffold: true, title: "Please wait...");
          } else if (dataSnapShot.hasError) {
            String errorMessage = dataSnapShot.error.toString();

            print("errorMessage ===> $errorMessage");

            if (errorMessage == "401") {
              //Ensures the callback executes after the current frame completes.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _navigateToSignInScreen();
              });

              return ErrorScreen(
                errorMessage: dataSnapShot.error.toString(),
                showScaffold: false,
                isNetworkError: false,
                retry: _retryFetchingUserData,
              );
            } else if (dataSnapShot.error is SocketException ||
                dataSnapShot.error is HandshakeException) {
              return ErrorScreen(
                  errorMessage: dataSnapShot.error.toString(),
                  isNetworkError: true,
                  retry: _retryFetchingUserData);
            } else {
              return ErrorScreen(
                  errorMessage: dataSnapShot.error.toString(),
                  isNetworkError: false,
                  retry: _retryFetchingUserData);
            }
          }

          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: postedDeals.length,
                itemBuilder: (context, index) {
                  return PostedCard(
                    onTap: () => _showPostedDealsBottomSheet(
                        postedDeals[index].id.toString()),
                    approvalStatus:
                        postedDeals[index].approvalStatus.toString(),
                    price: postedDeals[index].price.toString(),
                    promotionCode: postedDeals[index].promotionCode.toString(),
                    slashedPrice: postedDeals[index].slashedPrice.toString(),
                    title: postedDeals[index].title.toString(),
                  );
                },
              ));
        });
  }
}
