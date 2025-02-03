import 'package:tever/model/coordinate.dart';

class User {
  bool? hasSetupCheckList;
  bool? isEmailVerified;
  bool? isPhoneNumberVerified;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? businessName;
  String? storeName;
  String? businessLogo;
  String? userPlan;
  bool? isFirstTime;
  bool? is2FASet;
  bool? isAffiliate;
  bool? isSocialLogin;
  bool? isRequiredToSetPassword;
  bool? showNotificationPreview;
  bool? playSoundNotification;
  bool? phoneVerificationEnabled;
  bool? emailVerificationEnabled;
  bool? receiveEmailNotif;
  bool? receiveSmsNotif;
  bool? receiveInAppNotif;
  bool? isUserBlacklisted;
  dynamic businessDetails;
  dynamic bankDetails;
  int? percentageCompleted;
  int? totalSalesTillDate;
  dynamic planExpiryDate;
  dynamic preferences;
  dynamic kycStatus;
  Coordinate? currentAddress;

  User({
    this.hasSetupCheckList,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.businessName,
    this.storeName,
    this.businessLogo,
    this.userPlan,
    this.isFirstTime,
    this.is2FASet,
    this.isAffiliate,
    this.isSocialLogin,
    this.isRequiredToSetPassword,
    this.showNotificationPreview,
    this.playSoundNotification,
    this.phoneVerificationEnabled,
    this.emailVerificationEnabled,
    this.receiveEmailNotif,
    this.receiveSmsNotif,
    this.receiveInAppNotif,
    this.isUserBlacklisted,
    this.businessDetails,
    this.bankDetails,
    this.percentageCompleted,
    this.totalSalesTillDate,
    this.planExpiryDate,
    this.preferences,
    this.kycStatus,
    this.currentAddress,
    this.isEmailVerified,
    this.isPhoneNumberVerified,
  });

  factory User.defaultState() {
    return User(
      hasSetupCheckList: false,
      firstName: null,
      lastName: null,
      email: null,
      phoneNumber: null,
      businessName: null,
      storeName: null,
      businessLogo: null,
      userPlan: null,
      isFirstTime: true,
      is2FASet: false,
      isAffiliate: null,
      isSocialLogin: false,
      isRequiredToSetPassword: false,
      showNotificationPreview: false,
      playSoundNotification: false,
      phoneVerificationEnabled: null,
      emailVerificationEnabled: null,
      receiveEmailNotif: false,
      receiveSmsNotif: false,
      receiveInAppNotif: false,
      isUserBlacklisted: false,
      businessDetails: null,
      bankDetails: null,
      percentageCompleted: 0,
      totalSalesTillDate: 0,
      planExpiryDate: null,
      preferences: null,
      kycStatus: null,
      currentAddress: null,
      isEmailVerified: false,
      isPhoneNumberVerified: false,
    );
  }

  User copyWith({
    bool? hasSetupCheckList,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? businessName,
    String? storeName,
    String? businessLogo,
    String? userPlan,
    bool? isFirstTime,
    bool? is2FASet,
    bool? isAffiliate,
    bool? isSocialLogin,
    bool? isRequiredToSetPassword,
    bool? showNotificationPreview,
    bool? playSoundNotification,
    bool? phoneVerificationEnabled,
    bool? emailVerificationEnabled,
    bool? receiveEmailNotif,
    bool? receiveSmsNotif,
    bool? receiveInAppNotif,
    bool? isUserBlacklisted,
    dynamic businessDetails,
    dynamic bankDetails,
    int? percentageCompleted,
    int? totalSalesTillDate,
    dynamic planExpiryDate,
    dynamic preferences,
    dynamic kycStatus,
    Coordinate? currentAddress,
    String? latitude,
    String? longitude,
    bool? isEmailVerified,
    bool? isPhoneNumberVerified,
  }) {
    return User(
        hasSetupCheckList: hasSetupCheckList ?? this.hasSetupCheckList,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        businessName: businessName ?? this.businessName,
        storeName: storeName ?? this.storeName,
        businessLogo: businessLogo ?? this.businessLogo,
        userPlan: userPlan ?? this.userPlan,
        isFirstTime: isFirstTime ?? this.isFirstTime,
        is2FASet: is2FASet ?? this.is2FASet,
        isAffiliate: isAffiliate ?? this.isAffiliate,
        isSocialLogin: isSocialLogin ?? this.isSocialLogin,
        isRequiredToSetPassword:
            isRequiredToSetPassword ?? this.isRequiredToSetPassword,
        showNotificationPreview:
            showNotificationPreview ?? this.showNotificationPreview,
        playSoundNotification:
            playSoundNotification ?? this.playSoundNotification,
        phoneVerificationEnabled:
            phoneVerificationEnabled ?? this.phoneVerificationEnabled,
        emailVerificationEnabled:
            emailVerificationEnabled ?? this.emailVerificationEnabled,
        receiveEmailNotif: receiveEmailNotif ?? this.receiveEmailNotif,
        receiveSmsNotif: receiveSmsNotif ?? this.receiveSmsNotif,
        receiveInAppNotif: receiveInAppNotif ?? this.receiveInAppNotif,
        isUserBlacklisted: isUserBlacklisted ?? this.isUserBlacklisted,
        businessDetails: businessDetails ?? this.businessDetails,
        bankDetails: bankDetails ?? this.bankDetails,
        percentageCompleted: percentageCompleted ?? this.percentageCompleted,
        totalSalesTillDate: totalSalesTillDate ?? this.totalSalesTillDate,
        planExpiryDate: planExpiryDate ?? this.planExpiryDate,
        preferences: preferences ?? this.preferences,
        kycStatus: kycStatus ?? this.kycStatus,
        currentAddress: currentAddress ?? this.currentAddress,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        isPhoneNumberVerified:
            isPhoneNumberVerified ?? this.isPhoneNumberVerified);
  }

  User.fromJson(Map<String, dynamic> jsonData) {
    firstName = jsonData['user']['firstName'];
    lastName = jsonData['user']['lastName'];
    email = jsonData['user']['email'];
    phoneNumber = jsonData['user']['phoneNumber'];
    businessName = jsonData['user']['businessName'];
    storeName = jsonData['user']['storeName'];
    businessLogo = jsonData['user']['businessLogo'];
    userPlan = jsonData['user']['userPlan'];
    isFirstTime = jsonData['user']['isFirstTime'];
    is2FASet = jsonData['user']['is2FASet'];
    isAffiliate = jsonData['user']['isAffiliate'];
    isSocialLogin = jsonData['user']['isSocialLogin'];
    isRequiredToSetPassword = jsonData['user']['isRequiredToSetPassword'];
    showNotificationPreview = jsonData['user']['showNotificationPreview'];
    playSoundNotification = jsonData['user']['playSoundNotification'];
    phoneVerificationEnabled = jsonData['user']['phoneVerificationEnabled'];
    emailVerificationEnabled = jsonData['emailVerificatioEnabled'];
    receiveEmailNotif = jsonData['user']['receiveEmailNotif'];
    receiveSmsNotif = jsonData['user']['receiveSmsNotif'];
    receiveInAppNotif = jsonData['user']['receiveInAppNotif'];
    isUserBlacklisted = jsonData['user']['isUserBlacklisted'];
    businessDetails = jsonData['businessDetails'];
    bankDetails = jsonData['bankDetails'];
    percentageCompleted = jsonData['percentageCompleted'];
    totalSalesTillDate = jsonData['totalSalesTillDate'];
    planExpiryDate = jsonData['planExpiryDate'];
    preferences = jsonData['preferences'];
    kycStatus = jsonData['kycStatus'];
    isEmailVerified = jsonData['user']['isEmailVerified'] is bool
        ? jsonData['user']['isEmailVerified'] as bool
        : false;
    isPhoneNumberVerified = jsonData['user']['isPhoneVerified'] is bool
        ? jsonData['user']['isPhoneVerified'] as bool
        : false;
  }
}
