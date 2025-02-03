import 'package:tever/model/user.dart';

extension UserUpdate on User {
  User update(String key, dynamic value) {
    switch (key) {
      case 'hasSetupCheckList':
        return copyWith(hasSetupCheckList: value);
      case 'email':
        return copyWith(email: value);
      case 'phoneNumber':
        return copyWith(phoneNumber: value);
      case "currentAddress":
        return copyWith(currentAddress: value);
      case "firstName":
        return copyWith(firstName: value);
      case "lastName":
        return copyWith(lastName: value);
      case "hasSetUpProfile":
        return copyWith(isEmailVerified: value, isPhoneNumberVerified: value);
      default:
        throw Exception("Invalid key: $key");
    }
  }
}
