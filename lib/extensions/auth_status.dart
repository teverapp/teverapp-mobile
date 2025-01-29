enum AuthStatus {
  phone,
  email,
  signin,
  signup,
  hasNotConfirmedEmail,
  hasNotConfirmedPhoneNumber,
  hasNotSetPassword
}

extension AuthStatusExtension on AuthStatus {
  String get value {
    switch (this) {
      case AuthStatus.phone:
        return 'phone';
      case AuthStatus.email:
        return 'email';
      case AuthStatus.signin:
        return 'signin';
      case AuthStatus.signup:
        return 'signup';
      case AuthStatus.hasNotConfirmedEmail:
        return 'has_not_confirmed_email';
      case AuthStatus.hasNotConfirmedPhoneNumber:
        return 'has_not_confirmed_phone_number';
      case AuthStatus.hasNotSetPassword:
        return 'has_not_set_up_passwrd';
      default:
        return '';
    }
  }
}
