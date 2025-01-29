import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class PublishEventDialog extends StatelessWidget {
  const PublishEventDialog({super.key});

  final CustomColors _customColor = const CustomColors();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeInOut,
      ),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 358,
          ),
          padding:
              const EdgeInsets.only(top: 24, right: 16, left: 16, bottom: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: _customColor.customRgba2,
                offset: const Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: _customColor.customRgba3,
                offset: const Offset(0, 0),
                blurRadius: 1,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      color: _customColor.customFDF7ED, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icon/note_orange.png",
                    height: 16,
                    width: 16,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Publish Event",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _customColor.custom242424),
                    ),
                    const SizedBox(height: 6),
                    Flexible(
                        child: Text(
                      "You are about to publish your event. Once published, it will be visible to your audience.",
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _customColor.custom888888),
                    )),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Text(
                                "Continue editing",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _customColor.custom292929,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: const Text(
                                "Publish event",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ))
              ]),
        ),
      ),
    );
  }
}
