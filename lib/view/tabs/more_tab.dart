import 'package:flutter/material.dart';
import 'package:tever/view/widgets/tabs/home_tab/get_started_checklist.dart';
import 'package:tever/view/widgets/tabs/home_tab/quick_action.dart';
import 'package:tever/view/widgets/tabs/home_tab/trending_on_trevor.dart';
import 'package:tever/view/widgets/tabs/home_tab/welcome.dart';
import 'package:tever/view/widgets/tabs/more_tab/more.dart';
import 'package:tever/view/widgets/tabs/more_tab/personal.dart';
import 'package:tever/view/widgets/tabs/more_tab/profile_card.dart';
import 'package:tever/view/widgets/tabs/more_tab/services.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ProfileCard(),
          SizedBox(height: 22),
          Personal(),
          SizedBox(height: 22),
          Services(),
          SizedBox(height: 22),
          More(),
          SizedBox(
            height: kBottomNavigationBarHeight + 10,
          )
        ],
      ),
    );
  }
}


// Padding(
//         padding: EdgeInsets.only(right: 16, left: 16, top: 24),
//         child: 