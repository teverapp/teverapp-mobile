class TicketTier {
  String ticketName;
  String noOfTickets;
  bool unlimitedCapacity;
  String? ticketPrice;
  String? description;

  TicketTier({
    required this.ticketName,
    required this.noOfTickets,
    required this.unlimitedCapacity,
    this.ticketPrice,
    this.description,
  });
}
