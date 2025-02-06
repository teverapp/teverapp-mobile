class InputValidationController {
  bool validatePhoneNumber(String value) {
    final pattern = RegExp(r'^\+\d{1,3}\s?\d{4,13}$');
    return pattern.hasMatch(value);
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  bool validateEmail(String value) {
    final pattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    return pattern.hasMatch(value);
  }

  String getLastFourCharacters(String text) {
    if (text.length >= 4) {
      return text.substring(text.length - 4);
    } else {
      return text;
    }
  }

  String maskEmail(String email) {
    int atIndex = email.indexOf('@');

    // Ensuring there's a valid "@" and at least 3 characters before it.
    if (atIndex > 3) {
      // Everything except the last 3 characters before "@"
      String prefix = email.substring(0, atIndex - 3);

      String masked = '***';

      String domain = email.substring(atIndex);

      return '$prefix$masked$domain';
    } else {
      return "*";
    }
  }

  bool hasMinimumLength(String value, int minLength) {
    return value.length >= minLength;
  }

  bool containsLowercase(String value) {
    return RegExp(r'[a-z]').hasMatch(value);
  }

  bool containsUppercase(String value) {
    return RegExp(r'[A-Z]').hasMatch(value);
  }

  bool containsNumber(String value) {
    return RegExp(r'[0-9]').hasMatch(value);
  }

  bool containsSpecialCharacter(String value) {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
  }

  bool containsAlphabets(String value) {
    final pattern = RegExp(r'^[a-zA-Z]+$');
    return pattern.hasMatch(value);
  }

  bool containsNumbers(String value) {
    final pattern = RegExp(r'^\d+$');
    return pattern.hasMatch(value);
  }

  bool isImageUrl(String url) {
    final RegExp imageUrlRegExp = RegExp(
      r"(https?:\/\/.*\.(?:png|jpg|jpeg|gif|bmp|webp))",
      caseSensitive: false,
    );
    return imageUrlRegExp.hasMatch(url);
  }

  bool isValidUrl(String url) {
    final RegExp urlRegExp = RegExp(
      r"^(https?:\/\/)?([\w\d-]+\.)+[\w\d-]+(\/[^\s]*)?$",
      caseSensitive: false,
    );
    return urlRegExp.hasMatch(url);
  }

  bool validateTikTokProfileUrl(String value) {
    // Matches URLs like: https://www.tiktok.com/@username or tiktok.com/@username
    final RegExp pattern = RegExp(
      r'^(https?:\/\/)?(www\.)?tiktok\.com\/@[\w\-.]+\/?$',
      caseSensitive: false,
    );
    return pattern.hasMatch(value);
  }

  bool validateTwitterProfileUrl(String value) {
    // Matches URLs like: https://twitter.com/username or twitter.com/username
    final RegExp pattern = RegExp(
      r'^(https?:\/\/)?(www\.)?twitter\.com\/[\w_]+\/?$',
      caseSensitive: false,
    );
    return pattern.hasMatch(value);
  }

  bool validateInstagramProfileUrl(String value) {
    // Matches URLs like: https://www.instagram.com/username or instagram.com/username
    final RegExp pattern = RegExp(
      r'^(https?:\/\/)?(www\.)?instagram\.com\/[\w\.]+\/?$',
      caseSensitive: false,
    );
    return pattern.hasMatch(value);
  }

  bool validateThreadsProfileUrl(String value) {
    // Matches URLs like: https://www.threads.net/username or threads.net/username
    final RegExp pattern = RegExp(
      r'^(https?:\/\/)?(www\.)?threads\.net\/[\w\.]+\/?$',
      caseSensitive: false,
    );
    return pattern.hasMatch(value);
  }

  bool validateFacebookProfileUrl(String value) {
    // Matches URLs like: https://www.facebook.com/username or facebook.com/username
    final RegExp pattern = RegExp(
      r'^(https?:\/\/)?(www\.)?facebook\.com\/[\w\.]+\/?$',
      caseSensitive: false,
    );
    return pattern.hasMatch(value);
  }
}
