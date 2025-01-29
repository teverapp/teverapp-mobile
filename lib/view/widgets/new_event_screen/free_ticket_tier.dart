import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_event.dart';
import 'package:tever/view/widgets/general/common/dotted_widget.dart';
import 'package:tever/view/widgets/new_event_screen/tier_card.dart';

class FreeTicketTier extends ConsumerStatefulWidget {
  const FreeTicketTier({super.key});

  @override
  ConsumerState<FreeTicketTier> createState() => _FreeTicketTierState();
}

class _FreeTicketTierState extends ConsumerState<FreeTicketTier> {
  final CustomColors _customColor = const CustomColors();

  void _addMoreFreeTicketTier() {
    ref.read(newEventDataProvider.notifier).addFreeTicketTier(
        ticketTier: NewEvent.defaultState().freeTicketTier[0]);
  }

  void _updateTicketName({
    required int index,
    required String value,
  }) {
    ref.read(newEventDataProvider.notifier).updateFreeTicketName(
          value: value,
          index: index,
        );
  }

  void _updateTicketNumber({
    required int index,
    required String value,
  }) {
    ref.read(newEventDataProvider.notifier).updateFreeTicketNumberOfTickets(
          value: value,
          index: index,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final eventData = ref.watch(newEventDataProvider);

    return Column(
      children: [
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Column(
            children: [
              Column(
                children: eventData.freeTicketTier
                    .asMap()
                    .entries
                    .map((entry) => TierCard(
                          updateName: _updateTicketName,
                          updateTicketNumber: _updateTicketNumber,
                          isPaidTicket: false,
                          addSpacing:
                              entry.key != eventData.freeTicketTier.length - 1,
                          name: entry.value.ticketName,
                          noOfTickets: entry.value.noOfTickets,
                          price: entry.value.ticketPrice,
                          descriprion: entry.value.description,
                          index: entry.key + 1,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.topLeft,
                child: DottedBorderWidget(
                  borderColor: theme.primaryColor,
                  strokeWidth: 1,
                  dashWidth: 4,
                  dashSpacing: 4,
                  child: GestureDetector(
                    onTap: _addMoreFreeTicketTier,
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: _customColor.customFDF7ED,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/icon/add_gray.png",
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Add another tier",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: _customColor.custom242424,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
