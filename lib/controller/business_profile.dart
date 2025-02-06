import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:tever/extensions/update_business_profile.dart";
import "package:tever/model/common.dart";
import "package:tever/model/business_profile.dart";

class BusinessProfileControllerNotifier extends StateNotifier<BusinessProfile> {
  BusinessProfileControllerNotifier({required this.ref})
      : super(BusinessProfile.defaultState());
  final Ref ref;

  void updateBusinessProfile(String key, dynamic value) {
    state = state.update(key, value);
  }

  void addBusinessType({required String businessType}) {
    state = state.copyWith(businessType: businessType);
  }

  void addIndustry({required String industry}) {
    state = state.copyWith(industry: industry);
  }

  void addTwitter({required CommonType twitterUrl}) {
    state = state.copyWith(twitterUrl: twitterUrl);
  }

  void addTiktok({required CommonType tiktokUrl}) {
    state = state.copyWith(tiktokUrl: tiktokUrl);
  }

  void addInstagram({required CommonType instagramUrl}) {
    state = state.copyWith(instagramUrl: instagramUrl);
  }

  void addThreads({required CommonType threadsUrl}) {
    state = state.copyWith(threadsUrl: threadsUrl);
  }

  void faceBookThreads({required CommonType facebookUrl}) {
    state = state.copyWith(facebookUrl: facebookUrl);
  }
}

final businessProfileProvider =
    StateNotifierProvider<BusinessProfileControllerNotifier, BusinessProfile>(
        (ref) {
  return BusinessProfileControllerNotifier(ref: ref);
});
