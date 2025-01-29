import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class TierCard extends StatefulWidget {
  final int index;
  final String? descriprion;
  final String name;
  final String? price;
  final String noOfTickets;
  final bool addSpacing;
  final bool isPaidTicket;
  final void Function({
    required int index,
    required String value,
  })? updateName;
  final void Function({
    required int index,
    required String value,
  })? updateDescription;
  final void Function({
    required int index,
    required String value,
  })? updateTicketPrice;
  final void Function({
    required int index,
    required String value,
  })? updateTicketNumber;
  const TierCard(
      {super.key,
      required this.name,
      required this.noOfTickets,
      required this.index,
      required this.addSpacing,
      required this.isPaidTicket,
      this.price,
      this.descriprion,
      this.updateName,
      this.updateDescription,
      this.updateTicketNumber,
      this.updateTicketPrice});

  @override
  State<TierCard> createState() => _TierCardState();
}

class _TierCardState extends State<TierCard> {
  final CustomColors _customColor = const CustomColors();

  final TextEditingController _ticketNameControler = TextEditingController();

  final TextEditingController _noOfTicketsController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  late String currentTickets;

  void _updateTicketNumber(bool isIncrement) {
    final currentCount = int.tryParse(currentTickets) ?? 0;
    final updatedCount = isIncrement
        ? currentCount + 1
        : (currentCount - 1).clamp(0, double.infinity).toInt();
    currentTickets = updatedCount.toString();

    _noOfTicketsController.text = currentTickets;

    widget.updateTicketNumber
        ?.call(index: widget.index - 1, value: currentTickets);
  }

  @override
  void initState() {
    super.initState();

    _ticketNameControler.text = widget.name;

    _noOfTicketsController.text = widget.noOfTickets;

    _priceController.text = widget.price ?? "";

    _descriptionController.text = widget.descriprion ?? "";

    currentTickets = widget.noOfTickets;
    _noOfTicketsController.text = currentTickets;
  }

  @override
  void dispose() {
    super.dispose();
    _ticketNameControler.dispose();

    _noOfTicketsController.dispose();

    _priceController.dispose();

    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("updateFreeTicketNumberOfTickets build called");

    _noOfTicketsController.text = widget.noOfTickets;

    return Column(
      children: [
        Row(
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
            const SizedBox(width: 6),
            Text(
              "Tier ${widget.index}",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _customColor.custom242424),
            )
          ],
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _ticketNameControler,
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Ticket name",
            contentPadding: const EdgeInsets.all(16),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _customColor.customEFEFEF,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _customColor.customEFEFEF,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: _customColor.customEFEFEF,
                width: 1,
              ),
            ),
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
          onChanged: (value) {
            if (widget.updateName != null) {
              widget.updateName!(index: widget.index - 1, value: value);
            }
          },
        ),
        const SizedBox(height: 16),
        if (widget.isPaidTicket) ...[
          TextField(
            controller: _descriptionController,
            style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: "Description",
              filled: true,
              fillColor: Colors.white,
              prefixIconConstraints:
                  const BoxConstraints(maxHeight: 150, maxWidth: 150),
              prefixIcon: Container(
                margin: const EdgeInsets.only(left: 16, right: 10),
                child: Image.asset(
                  "assets/icon/book.png",
                  height: 16,
                  width: 16,
                ),
              ),
              contentPadding: const EdgeInsets.all(16),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
              ),
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
            onChanged: (value) {
              if (widget.updateDescription != null) {
                widget.updateDescription!(
                    index: widget.index - 1, value: value);
              }
            },
          ),
          const SizedBox(height: 16),
          Container(
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: _customColor.customEFEFEF,
                )),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: 44,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          width: 1, color: _customColor.customEFEFEF),
                    ),
                  ),
                  child: Text(
                    "₦",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: _customColor.custom6B7280),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    style: TextStyle(
                      color: _customColor.custom242424,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: "Ticket Price",
                      contentPadding: const EdgeInsets.only(left: 16),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom888888,
                      ),
                    ),
                    onChanged: (value) {
                      if (widget.updateTicketPrice != null) {
                        widget.updateTicketPrice!(
                            index: widget.index - 1, value: value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        Container(
          height: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: _customColor.customEFEFEF,
              )),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: _noOfTicketsController,
                  style: TextStyle(
                    color: _customColor.custom242424,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: "Number of tickets",
                    contentPadding: const EdgeInsets.only(left: 16),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _customColor.custom888888,
                    ),
                  ),
                  onChanged: (value) async {},
                ),
              ),
              GestureDetector(
                  onTap: () => _updateTicketNumber(true), // Increment tickets
                  child: Container(
                    alignment: Alignment.center,
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 1, color: _customColor.customEFEFEF),
                          left: BorderSide(
                              width: 1, color: _customColor.customEFEFEF)),
                    ),
                    child: Image.asset(
                      "assets/icon/add_gray.png",
                      height: 24,
                      width: 24,
                    ),
                  )),
              GestureDetector(
                onTap: () => _updateTicketNumber(false), // Increment tickets
                child: Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            width: 1, color: _customColor.customEFEFEF),
                        left: BorderSide(
                            width: 1, color: _customColor.customEFEFEF)),
                  ),
                  child: Image.asset(
                    "assets/icon/minus_gray.png",
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.addSpacing)
          const SizedBox(
            height: 20,
          ),
      ],
    );
  }
}
