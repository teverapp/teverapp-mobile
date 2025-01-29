import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/model/new_event.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_event_screen/free_ticket_tier.dart';
import 'package:tever/view/widgets/new_event_screen/paid_ticket_tier.dart';
import 'package:tever/view/widgets/new_event_screen/tickets_top_tab.dart';

class TicketsSection extends ConsumerStatefulWidget {
  final Function proceed;
  const TicketsSection({
    super.key,
    required this.proceed,
  });

  @override
  ConsumerState<TicketsSection> createState() => _TicketsSectionState();
}

class _TicketsSectionState extends ConsumerState<TicketsSection> {
  int _selectedSection = 0;

  void _selectTicket(int index) {
    setState(() {
      _selectedSection = index;
    });
  }

  void _showToast({
    required String message,
    required String status,
    required BuildContext context,
  }) {
    ToastService.showToast(
      context: context,
      message: message,
      status: status,
    );
  }

  bool _validatePaidTicket({required NewEvent newEventData}) {
    final paidTicketValidations = [
      {
        "condition": newEventData.paidTicketTier.any(
          (ticket) =>
              ticket.ticketName == "" ||
              ticket.noOfTickets == "" ||
              ticket.description == "" ||
              ticket.ticketPrice == "",
        ),
        "message": "Please complete your ticket tire(s)!"
      },
    ];

    for (var validation in paidTicketValidations) {
      if (validation["condition"] as bool) {
        _showToast(
          message: validation["message"].toString(),
          status: ToastStatus.error.name,
          context: context,
        );
        return false;
      }
    }
    return true;
  }

  bool _validateSharedFields({required NewEvent newEventData}) {
    final sharedValidations = [
      {
        "condition": newEventData.freeTicketTier.any((document) =>
            document.ticketName == "" || document.noOfTickets == ""),
        "message": "Please complete your ticket tire(s)!"
      },
    ];

    for (var validation in sharedValidations) {
      if (validation["condition"] as bool) {
        _showToast(
          message: validation["message"].toString(),
          status: ToastStatus.error.name,
          context: context,
        );
        return false;
      }
    }
    return true;
  }

  void _continue() {
    final newEventData = ref.watch(newEventDataProvider);

    if (!_validateSharedFields(newEventData: newEventData)) {
      return;
    }

    if (_selectedSection == 1) {
      if (!_validatePaidTicket(newEventData: newEventData)) {
        return;
      }
    }

    widget.proceed(2);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
          top: 24,
        ),
        child: Column(
          children: [
            TicketsTopTab(selectTicket: _selectTicket),
            if (_selectedSection == 0) const FreeTicketTier(),
            if (_selectedSection == 1) const PaidTicketTier(),
            const SizedBox(height: 40),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: TextButton(
                onPressed: _continue,
                style: TextButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
