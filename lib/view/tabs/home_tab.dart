import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/auth_controller.dart';
import 'package:tever/controller/user_controller.dart';
import 'package:tever/view/widgets/tabs/home_tab/business_profile_created_successfull_bottom_sheet.dart';
import 'package:tever/view/widgets/tabs/home_tab/get_started_checklist.dart';
import 'package:tever/view/widgets/tabs/home_tab/quick_action.dart';
import 'package:tever/view/widgets/tabs/home_tab/trending_on_trevor.dart';
import 'package:tever/view/widgets/tabs/home_tab/welcome.dart';

class HomeTab extends ConsumerStatefulWidget {
  final bool justCreatedBusnessProfile;
  const HomeTab({super.key, this.justCreatedBusnessProfile = false});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  bool _hasSetupCheckList = false;

  void _businessProfileCreatedHandler() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const BusinessProfileCreatedSuccessfullBottomSheet();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.justCreatedBusnessProfile && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _businessProfileCreatedHandler();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);

    _hasSetupCheckList = userData.hasSetupCheckList ?? false;

    final authData = ref.read(authProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
        child: Column(
          children: [
            const Welcome(),
            if (!authData.isGuest)
              if (!_hasSetupCheckList) const GetStartedChecklist(),
            const QuickAction(),
            const TrendingOnTrevor(),
            const SizedBox(height: kBottomNavigationBarHeight + 10)
          ],
        ),
      ),
    );
  }
}
