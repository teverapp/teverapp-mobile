// import 'package:flutter/material.dart';

// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:ebocab_driver/helpers/custom_colors.dart';

// class SubmissionSuccess extends StatelessWidget {
//   final VoidCallback submissionSuccessCallbkFn;
//   final String title;
//   const SubmissionSuccess(
//       {super.key,
//       required this.submissionSuccessCallbkFn,
//       required this.title});
//   final CustomColors _customColor = const CustomColors();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Container(
//             height: double.infinity,
//             width: double.infinity,
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             alignment: Alignment.topCenter,
//             child: Container(
//               height: 56,
//               padding: const EdgeInsets.only(left: 12, right: 17),
//               decoration: BoxDecoration(
//                 color: _customColor.customF8F8F8,
//                 borderRadius: BorderRadius.circular(48),
//                 boxShadow: [
//                   BoxShadow(
//                     color: _customColor.custom000000,
//                     offset: const Offset(0, 4),
//                     blurRadius: 22,
//                     spreadRadius: 0,
//                   ),
//                 ],
//               ),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Image.asset("assets/icons/green_rounded_check.png",
//                         height: 32, width: 32),
//                     const SizedBox(width: 10),
//                     Text(
//                       title,
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: _customColor.custom080808),
//                     )
//                   ]),
//             )
//                 .animate()
//                 .slideY(begin: -60, end: 1, duration: 3400.ms, delay: 0.ms)
//                 .then()
//                 .slideY(
//                   begin: 1,
//                   end: -60,
//                   delay: 2.seconds,
//                   duration: 1000.ms,
//                 )
//                 .callback(callback: (_) {
//               Navigator.of(context).pop();
//               submissionSuccessCallbkFn();
//             })));
//   }
// }
