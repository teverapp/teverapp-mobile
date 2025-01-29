import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/screens/get_started_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CustomColors _customColors = const CustomColors();

  final PageController _pageController = PageController();

  int _activePageIndex = 0;

  late Timer _timer;

  final List<Map<String, String>> _onboardingPage = [
    {
      "image": "assets/image/onboarding1.png",
      "title": "Welcome to Tever!",
      "subTitle": "Discover local businesses near you"
    },
    {
      "image": "assets/image/onboarding2.png",
      "title": "Find what you need!",
      "subTitle": "Explore products and services from trusted sellers."
    },
    {
      "image": "assets/image/onboarding3.png",
      "title": "Navigate with confidence",
      "subTitle":
          "Get directions to your favorite shops and sellers, and discover new businesses."
    },
    {
      "image": "assets/image/onboarding4.png",
      "title": "Shop and pay seamlessly",
      "subTitle": "Enjoy a smooth shopping experience with easy payments."
    },
    {
      "image": "assets/image/onboarding5.png",
      "title": "Hassle-free deliveries",
      "subTitle":
          "Count on quick and reliable logistics to get your purchases delivered."
    },
    {
      "image": "assets/image/onboarding6.png",
      "title": "Explore local markets",
      "subTitle":
          "Easily discover and connect with local businesses and market sellers."
    },
  ];

  _navigateToNextScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const GetStartedScreen()),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_activePageIndex < _onboardingPage.length - 1) {
        setState(() {
          _activePageIndex++;
          _pageController.animateToPage(
            _activePageIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      } else {
        _navigateToNextScreen();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final theme = Theme.of(context);

    final height = mediaQuery.height * 0.7;
    return Scaffold(
        body: Stack(children: [
      PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _activePageIndex = index;
          });
        },
        children: _onboardingPage
            .map((value) => Container(
                  color: Colors.black,
                  child: Column(
                    children: [
                      Container(
                        height: height,
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              value["image"].toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              value["title"].toString(),
                              style: TextStyle(
                                  fontFamily: "Anybody",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: _customColors.custom242424),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              value["subTitle"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: _customColors.custom2E3438),
                            ),
                            const SizedBox(height: 71),
                            GestureDetector(
                              onTap: _navigateToNextScreen,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: _customColors.customEFEFEF),
                                height: 32,
                                width: 72,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Skip",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: _customColors.custom242424,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Image.asset(
                                      "assets/icon/arrow_right_dark_thick.png",
                                      height: 16,
                                      width: 16,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                ))
            .toList(),
      ),
      Positioned(
        right: 0,
        left: 0,
        top: height + 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _onboardingPage
              .asMap()
              .entries
              .map(
                (entry) => Container(
                    margin: EdgeInsets.only(
                        right: _onboardingPage.length - 1 == entry.key ? 0 : 4),
                    decoration: BoxDecoration(
                        color: _activePageIndex == entry.key
                            ? theme.primaryColor
                            : _customColors.customFDF7ED,
                        borderRadius: BorderRadius.circular(100)),
                    height: 4,
                    width: 32),
              )
              .toList(),
        ),
      ),
      Positioned(
        top: 60,
        right: 0,
        left: 0,
        child: Image.asset(
          "assets/logo/logo_light.png",
          height: 24,
          width: 92.79,
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
          height: 24,
          width: double.infinity,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/image/patterns.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ]));
  }
}





// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:tever/helpers/custom_colors.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final CustomColors _customColors = const CustomColors();
//   final PageController _pageController = PageController();
//   late Timer _timer;

//   int _activePageIndex = 0;

//   final List<Map<String, String>> _onboardingPage = [
//     {
//       "image": "assets/image/get_started_image.png",
//       "title": "Welcome to Tever!",
//       "subTitle": "Discover local businesses near you"
//     },
//     {
//       "image": "assets/image/get_started_image.png",
//       "title": "Explore with ease!",
//       "subTitle": "Find trusted businesses quickly"
//     },
//     {
//       "image": "assets/image/get_started_image.png",
//       "title": "Get Started Today!",
//       "subTitle": "Sign up to enjoy personalized services"
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
//       if (_activePageIndex < _onboardingPage.length - 1) {
//         setState(() {
//           _activePageIndex++;
//           _pageController.animateToPage(
//             _activePageIndex,
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.easeInOut,
//           );
//         });
//       } else {
//         // Stop the timer when the last page is reached
//         _timer.cancel();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context).size;

//     final height = mediaQuery.height * 0.7;

//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _activePageIndex = index;
//               });
//             },
//             itemCount: _onboardingPage.length,
//             itemBuilder: (context, index) {
//               final page = _onboardingPage[index];
//               return Container(
//                 color: Colors.black,
//                 child: Column(
//                   children: [
//                     Container(
//                       height: height,
//                       width: double.infinity,
//                       alignment: Alignment.topCenter,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(page["image"]!),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         color: Colors.white,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               page["title"]!,
//                               style: TextStyle(
//                                 fontFamily: "Anybody",
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 22,
//                                 color: _customColors.custom242424,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               page["subTitle"]!,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: _customColors.custom2E3438,
//                               ),
//                             ),
//                             const SizedBox(height: 71),
//                             GestureDetector(
//                               onTap: () {
//                                 // Skip to the last page
//                                 _pageController.animateToPage(
//                                   _onboardingPage.length - 1,
//                                   duration: const Duration(milliseconds: 500),
//                                   curve: Curves.easeInOut,
//                                 );
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(100),
//                                   color: _customColors.customEFEFEF,
//                                 ),
//                                 height: 32,
//                                 width: 72,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "Skip",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500,
//                                         color: _customColors.custom242424,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 4),
//                                     Image.asset(
//                                       "assets/icon/arrow_right.png",
//                                       height: 16,
//                                       width: 16,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 _onboardingPage.length,
//                 (index) => Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   width: _activePageIndex == index ? 16 : 8,
//                   height: 8,
//                   decoration: BoxDecoration(
//                     color: _activePageIndex == index
//                         ? Theme.of(context).primaryColor
//                         : _customColors.customEFEFEF,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
