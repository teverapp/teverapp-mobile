import 'package:flutter/material.dart';

import 'package:tever/view/widgets/new_event_screen/add_cover_image.dart';
import 'package:tever/view/widgets/new_event_screen/new_event_form.dart';

class NewEventSection extends StatelessWidget {
  final Function proceed;
  const NewEventSection({super.key, required this.proceed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
        child: Column(
          children: [
            const AddCoverImage(),
            const SizedBox(height: 24),
            NewEventForm(
              proceed: proceed,
            ),
          ],
        ),
      ),
    );
  }
}
