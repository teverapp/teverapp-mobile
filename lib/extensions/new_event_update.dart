import 'package:tever/model/new_event.dart';

extension NewEventUpdate on NewEvent {
  NewEvent update(String key, dynamic value) {
    switch (key) {
      case "coverimage":
        return copyWith(coverImage: value);
      case "eventName":
        return copyWith(eventName: value);
      case "description":
        return copyWith(description: value);
      case "eventType":
        return copyWith(eventType: value);
      case "hostingPlatform":
        return copyWith(hostingPlatform: value);
      case "addressOfEvent":
        return copyWith(addressOfEvent: value);
      case "eventLink":
        return copyWith(eventLink: value);
      case "timeZone":
        return copyWith(timeZone: value);
      case "startTimeAndDate":
        return copyWith(startTimeAndDate: value);
      case "endTimeAndDate":
        return copyWith(endTimeAndDate: value);
      case "eventCategory":
        return copyWith(eventCategory: value);

      default:
        throw Exception("Invalid key: $key");
    }
  }
}
