import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/new_event.dart';
import 'package:tever/view/widgets/general/common/dotted_widget.dart';
import 'package:tever/view/widgets/new_event_screen/tier_card.dart';

class PaidTicketTier extends ConsumerStatefulWidget {
  const PaidTicketTier({super.key});

  @override
  ConsumerState<PaidTicketTier> createState() => _PaidTicketTierState();
}

class _PaidTicketTierState extends ConsumerState<PaidTicketTier> {
  void _addMorePaidTicketTier() {
    ref.read(newEventDataProvider.notifier).addPaidTicketTier(
        ticketTier: NewEvent.defaultState().freeTicketTier[0]);
  }

  void _addMoreFreeTicketTier() {
    ref.read(newEventDataProvider.notifier).addFreeTicketTier(
        ticketTier: NewEvent.defaultState().freeTicketTier[0]);
  }

  void _updateTicketName({
    required int index,
    required String value,
  }) {
    ref.read(newEventDataProvider.notifier).updatePaidTicketName(
          value: value,
          index: index,
        );
  }

  void _updateTicketDescription({
    required int index,
    required String value,
  }) {
    ref.read(newEventDataProvider.notifier).updatePaidTicketDescription(
          value: value,
          index: index,
        );
  }

  void _updateTicketPrice({
    required int index,
    required String value,
  }) {
    ref.read(newEventDataProvider.notifier).updatePaidTicketPrice(
          value: value,
          index: index,
        );
  }

  void _updateTicketNumber({
    required int index,
    required String value,
  }) {
    ref.read(newEventDataProvider.notifier).updatePaidTicketNumberOfTickets(
          value: value,
          index: index,
        );
  }

  final CustomColors _customColor = const CustomColors();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final newEventData = ref.watch(newEventDataProvider);

    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: _customColor.customFDF7ED, shape: BoxShape.circle),
                  child: Image.asset(
                    "assets/icon/ticket.png",
                    height: 16,
                    width: 16,
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Regular Ticket",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _customColor.custom242424),
                        ),
                        Image.asset(
                          "assets/icon/edit.png",
                          height: 16,
                          width: 16,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 120,
                      child: TextFormField(
                        style: TextStyle(
                          color: _customColor.customB0B0B0,
                          fontSize: 14,
                        ),
                        maxLines: null,
                        minLines: 5,
                        initialValue:
                            "Gain access to the event venue and enjoy all the core activities, including keynote sessions, panel discussions, and networking opportunities. This ticket ensures you don’t miss the main event highlights, providing an experience filled with inspiration, learning, and connections.",
                        decoration: InputDecoration(
                          hintText: "Enter description",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(
                              top: 16, bottom: 16, right: 16),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(width: 1),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _customColor.custom888888,
                          ),
                        ),
                        onChanged: (value) async {},
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 17.03,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 1,
                                      color: _customColor.customDCDCDC))),
                          padding: const EdgeInsets.only(right: 12),
                          margin: const EdgeInsets.only(right: 12),
                          child: Text(
                            "Price - ₦15,000",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _customColor.custom5D5D5D),
                          ),
                        ),
                        Text(
                          "Capacity - 80",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _customColor.custom5D5D5D),
                        ),
                      ],
                    )
                  ],
                ))
              ],
            )),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Column(
            children: [
              Column(
                children: newEventData.paidTicketTier
                    .asMap()
                    .entries
                    .map(
                      (entry) => TierCard(
                        isPaidTicket: true,
                        updateDescription: _updateTicketDescription,
                        updateTicketPrice: _updateTicketPrice,
                        updateName: _updateTicketName,
                        updateTicketNumber: _updateTicketNumber,
                        addSpacing:
                            entry.key != newEventData.paidTicketTier.length - 1,
                        name: entry.value.ticketName,
                        noOfTickets: entry.value.noOfTickets,
                        price: entry.value.ticketPrice,
                        descriprion: entry.value.description,
                        index: entry.key + 1,
                      ),
                    )
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
                    onTap: _addMorePaidTicketTier,
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
