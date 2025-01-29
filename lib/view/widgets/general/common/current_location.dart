import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/app_info_controller.dart';
import 'package:tever/controller/user_controller.dart';

class CurrentLocation extends ConsumerWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final userData = ref.watch(userDataProvider);

    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 100),
          Expanded(
            child: Text(
              userData.currentAddress.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            "assets/icon/location_blue.png",
            height: 16,
            width: 16,
          ),
        ],
      ),
    );
  }
}
