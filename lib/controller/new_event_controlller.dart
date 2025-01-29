import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:tever/extensions/new_event_update.dart";
import "package:tever/model/new_event.dart";
import "package:tever/model/ticket_tier.dart";

class NewEventControllerNotifier extends StateNotifier<NewEvent> {
  NewEventControllerNotifier({required this.ref})
      : super(NewEvent.defaultState());
  final Ref ref;

  void updateNewEvent(String key, dynamic value) {
    state = state.update(key, value);
  }

  void resetEvent() {
    state = NewEvent.defaultState();
  }

  void addFreeTicketTier({required TicketTier ticketTier}) {
    final updatedTicketTier = [...state.freeTicketTier, ticketTier];

    state = state.copyWith(freeTicketTier: updatedTicketTier);
  }

  void updateFreeTicketName({required String value, required int index}) {
    final ticketVarient = List<TicketTier>.from(state.freeTicketTier);

    ticketVarient[index].ticketName = value;

    state = state.copyWith(freeTicketTier: ticketVarient);
  }

  void updateFreeTicketNumberOfTickets(
      {required String value, required int index}) {
    final ticketVarient = List<TicketTier>.from(state.freeTicketTier);
    print("Updating... ${value}");
    ticketVarient[index].noOfTickets = value;

    state = state.copyWith(freeTicketTier: ticketVarient);
  }

  void addPaidTicketTier({required TicketTier ticketTier}) {
    final updatedTicketTier = [...state.paidTicketTier, ticketTier];

    state = state.copyWith(paidTicketTier: updatedTicketTier);
  }

  void updatePaidTicketName({required String value, required int index}) {
    final ticketVarient = List<TicketTier>.from(state.paidTicketTier);

    ticketVarient[index].ticketName = value;

    print("updatePaidTicket name $value");

    state = state.copyWith(paidTicketTier: ticketVarient);
  }

  void updatePaidTicketDescription(
      {required String value, required int index}) {
    final ticketVarient = List<TicketTier>.from(state.paidTicketTier);

    print("updatePaidTicket desc $value");
    ticketVarient[index].description = value;

    state = state.copyWith(paidTicketTier: ticketVarient);
  }

  void updatePaidTicketPrice({required String value, required int index}) {
    final ticketVarient = List<TicketTier>.from(state.paidTicketTier);

    ticketVarient[index].ticketPrice = value;
    print("updatePaidTicket price $value");
    state = state.copyWith(paidTicketTier: ticketVarient);
  }

  void updatePaidTicketNumberOfTickets(
      {required String value, required int index}) {
    final ticketVarient = List<TicketTier>.from(state.paidTicketTier);

    ticketVarient[index].noOfTickets = value;

    print("updatePaidTicket nu $value");

    state = state.copyWith(paidTicketTier: ticketVarient);
  }
}

final newEventDataProvider =
    StateNotifierProvider<NewEventControllerNotifier, NewEvent>((ref) {
  return NewEventControllerNotifier(ref: ref);
});
