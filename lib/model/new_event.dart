import 'dart:io';

import 'package:tever/model/common.dart';
import 'package:tever/model/coordinate.dart';
import 'package:tever/model/ticket_tier.dart';

class NewEvent {
  File? coverImage;
  String eventName;
  String description;
  CommonType? eventType;
  CommonType? hostingPlatform;
  Coordinate? addressOfEvent;
  String eventLink;
  String? timeZone;
  String startTimeAndDate;
  String endTimeAndDate;
  CommonType? eventCategory;
  List<TicketTier> freeTicketTier;
  List<TicketTier> paidTicketTier;

  NewEvent({
    required this.coverImage,
    required this.eventName,
    required this.description,
    required this.eventType,
    required this.hostingPlatform,
    required this.addressOfEvent,
    required this.eventLink,
    required this.timeZone,
    required this.startTimeAndDate,
    required this.endTimeAndDate,
    required this.eventCategory,
    required this.freeTicketTier,
    required this.paidTicketTier,
  });

  factory NewEvent.defaultState() {
    return NewEvent(
        coverImage: null,
        eventName: "",
        description: "",
        eventType: null,
        hostingPlatform: null,
        addressOfEvent: null,
        eventLink: "",
        timeZone: null,
        startTimeAndDate: "",
        endTimeAndDate: "",
        eventCategory: null,
        freeTicketTier: [
          TicketTier(
            ticketName: "",
            noOfTickets: "",
            description: null,
            unlimitedCapacity: false,
            ticketPrice: null,
          )
        ],
        paidTicketTier: [
          TicketTier(
            ticketName: "",
            noOfTickets: "",
            description: "",
            unlimitedCapacity: false,
            ticketPrice: "",
          )
        ]);
  }

  NewEvent copyWith({
    File? coverImage,
    String? eventName,
    String? description,
    CommonType? eventType,
    CommonType? hostingPlatform,
    Coordinate? addressOfEvent,
    String? eventLink,
    String? timeZone,
    String? startTimeAndDate,
    String? endTimeAndDate,
    CommonType? eventCategory,
    List<TicketTier>? freeTicketTier,
    List<TicketTier>? paidTicketTier,
  }) {
    return NewEvent(
      coverImage: coverImage ?? this.coverImage,
      eventName: eventName ?? this.eventName,
      description: description ?? this.description,
      eventType: eventType ?? this.eventType,
      hostingPlatform: hostingPlatform ?? this.hostingPlatform,
      addressOfEvent: addressOfEvent ?? this.addressOfEvent,
      eventLink: eventLink ?? this.eventLink,
      timeZone: timeZone ?? this.timeZone,
      startTimeAndDate: startTimeAndDate ?? this.startTimeAndDate,
      endTimeAndDate: endTimeAndDate ?? this.endTimeAndDate,
      eventCategory: eventCategory ?? this.eventCategory,
      paidTicketTier: paidTicketTier ?? this.paidTicketTier,
      freeTicketTier: freeTicketTier ?? this.freeTicketTier,
    );
  }
}

final List<CommonType> newEventType = [
  CommonType(
    id: "1",
    name: "Physical event",
  ),
  CommonType(
    id: "2",
    name: "Virtual event",
  ),
];

final List<CommonType> hostingPlatform = [
  CommonType(
    id: "1",
    name: "Google Meet",
    imageUrl: "google_meet.png",
  ),
  CommonType(
    id: "2",
    name: "Zoom",
    imageUrl: "zoom.png",
  ),
  CommonType(
    id: "1",
    name: "Zoho Live",
    imageUrl: "zoho.png",
  ),
];

final List<CommonType> eventCategories = [
  CommonType(name: "Karaoke", imageUrl: "microphone_gray.png"),
  CommonType(name: "Yoga", imageUrl: "yoga.png"),
  CommonType(name: "Food", imageUrl: "cake.png"),
  CommonType(name: "Sports", imageUrl: "dumbbell.png"),
  CommonType(name: "Gaming", imageUrl: "game.png"),
  CommonType(name: "Music", imageUrl: "music.png"),
  CommonType(name: "Beauty and lifestyle", imageUrl: "scissor.png"),
  CommonType(name: "Technology", imageUrl: "devices.png"),
  CommonType(name: "Arts and Design", imageUrl: "designtools.png"),
];
