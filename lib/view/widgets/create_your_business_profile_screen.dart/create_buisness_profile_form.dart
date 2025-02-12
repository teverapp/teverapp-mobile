import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/business_profile.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/extensions/toast_status.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/model/coordinate.dart';
import 'package:tever/model/country.dart';
import 'package:tever/model/business_profile.dart';
import 'package:tever/model/custom_http_exception.dart';
import 'package:tever/view/screens/new_deal_screen.dart';
import 'package:tever/view/screens/sign_in_screen.dart';
import 'package:tever/view/widgets/create_your_business_profile_screen.dart/business_type_bottom_sheet.dart';
import 'package:tever/view/widgets/create_your_business_profile_screen.dart/save_business_profile_details_button.dart';
import 'package:tever/view/widgets/general/common/custom_input_selection_button.dart';
import 'package:tever/view/widgets/general/common/toast_service.dart';
import 'package:tever/view/widgets/new_event_screen/address_list_bottom_sheet.dart';
import 'package:tever/view/widgets/new_event_screen/choose_picture_type_dialog.dart';
import 'package:tever/view/widgets/sign_up_screen/email_input.dart';
import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';

class CreateBuisnessProfileForm extends ConsumerStatefulWidget {
  final bool isCreatedFromNewDeals;
  const CreateBuisnessProfileForm(
      {super.key, required this.isCreatedFromNewDeals});

  @override
  ConsumerState<CreateBuisnessProfileForm> createState() =>
      _CreateBuisnessProfileFormState();
}

class _CreateBuisnessProfileFormState
    extends ConsumerState<CreateBuisnessProfileForm> {
  final CustomColors _customColor = const CustomColors();

  final TextEditingController _businessNameController = TextEditingController();

  final TextEditingController _brandNameController = TextEditingController();

  final TextEditingController _tiktokController = TextEditingController();

  final TextEditingController _twitterController = TextEditingController();

  final TextEditingController _instagramController = TextEditingController();

  final TextEditingController _threadsController = TextEditingController();

  final TextEditingController _facebookController = TextEditingController();

  final TextEditingController _phoneNoController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _aboutBusinessController =
      TextEditingController();

  void _emailValidator(bool? hasError) {
    ref
        .read(businessProfileProvider.notifier)
        .updateBusinessProfile("emailHasError", hasError ?? false);
  }

  void _phoneNumberValidator(bool? hasError) {
    ref
        .read(businessProfileProvider.notifier)
        .updateBusinessProfile("phoneNumberHasError", hasError ?? false);
  }

  void _emailOnChangeHandler(String email) {
    ref
        .read(businessProfileProvider.notifier)
        .updateBusinessProfile("email", email);
  }

  void _phoneNumberOnChangeHandler(String phoneNumber) {
    ref
        .read(businessProfileProvider.notifier)
        .updateBusinessProfile("phoneNumber", phoneNumber);
  }

  void _selectCountry(Country selectedCountry) {
    ref.read(businessProfileProvider.notifier).updateBusinessProfile(
          "selectedPhoneNumberCountryDetails",
          selectedCountry,
        );
  }

  void _selectBusinessType(
      {required String value, required String id, String? imageUrl}) {
    ref
        .read(businessProfileProvider.notifier)
        .updateBusinessProfile("businessType", value);

    ref
        .read(businessProfileProvider.notifier)
        .updateBusinessProfile("businessTypeId", id);
  }

  void _selectIndustry(
      {required String value, required String id, String? imageUrl}) {
    ref
        .read(businessProfileProvider.notifier)
        .updateBusinessProfile("industry", value);

    ref
        .read(businessProfileProvider.notifier)
        .updateBusinessProfile("industryId", id);
  }

  void _selectAddress({required Coordinate location}) {
    ref
        .read(businessProfileProvider.notifier)
        .updateBusinessProfile("address", location);
  }

  void _showAddressBottomSheet({String? searchInput}) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return AddressListButtomSheet(
          title: "Enter address",
          intialSearchInput: searchInput,
          selectLocation: _selectAddress,
        );
      },
    );
  }

  void _showBusinessCreationButtomSheet({
    required List<CommonType> dropdownItems,
    required double height,
    required String title,
    required Function(
            {required String value, required String id, String? imageUrl})
        selectItem,
    required String? selectedItem,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return BusinessTypeBottomSheet(
          title: title,
          height: height,
          selectItem: selectItem,
          selectedIetm: selectedItem,
          dropdownItems: dropdownItems,
        );
      },
    );
  }

  void _selectImageTypeDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return ChoosePictureTypeDialog(
          uploadImage: _pickImage,
        );
      },
    );
  }

  void _pickImage(File imageFile) {
    ref
        .read(businessProfileProvider.notifier)
        .updateBusinessProfile("businessLogo", imageFile);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final creatingBusinessProfile = ref.watch(businessProfileProvider);

      _businessNameController.text = creatingBusinessProfile.businessName;

      _brandNameController.text = creatingBusinessProfile.brandName;

      _tiktokController.text = creatingBusinessProfile.tiktokUrl.name;

      _twitterController.text = creatingBusinessProfile.twitterUrl.name;

      _instagramController.text = creatingBusinessProfile.instagramUrl.name;

      _threadsController.text = creatingBusinessProfile.threadsUrl.name;

      _facebookController.text = creatingBusinessProfile.facebookUrl.name;

      _phoneNoController.text = creatingBusinessProfile.phoneNumber;

      _emailController.text = creatingBusinessProfile.email;

      _aboutBusinessController.text = creatingBusinessProfile.aboutBusiness;
    });
  }

  @override
  void dispose() {
    super.dispose();

    _businessNameController.dispose();

    _brandNameController.dispose();

    _tiktokController.dispose();

    _twitterController.dispose();

    _instagramController.dispose();

    _threadsController.dispose();

    _facebookController.dispose();

    _phoneNoController.dispose();

    _aboutBusinessController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final creatingBusinessProfile = ref.watch(businessProfileProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          "Business logo",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: _customColor.customEFEFEF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _selectImageTypeDialog,
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icon/file.png",
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Upload image",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _customColor.custom6D6D6D,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Business name",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        TextField(
          controller: _businessNameController,
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Name you registered as business name",
            filled: true,
            fillColor: Colors.white,
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
            ref
                .read(businessProfileProvider.notifier)
                .updateBusinessProfile("businessName", value);
          },
        ),
        const SizedBox(height: 16),
        Text(
          "Brand/ trade name",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        TextField(
          controller: _brandNameController,
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Name you trade with",
            filled: true,
            fillColor: Colors.white,
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
            ref
                .read(businessProfileProvider.notifier)
                .updateBusinessProfile("brandName", value);
          },
        ),
        const SizedBox(height: 16),
        Text(
          "Business type",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        CustomInputSelectionButton(
          hasSelected: creatingBusinessProfile.businessType != null,
          onTap: () => _showBusinessCreationButtomSheet(
            title: "Business Types",
            height: 200,
            dropdownItems: businessTypes,
            selectItem: _selectBusinessType,
            selectedItem: creatingBusinessProfile.businessType,
          ),
          selectedItem: creatingBusinessProfile.businessType != null
              ? creatingBusinessProfile.businessType.toString()
              : "Choose all that apply",
        ),
        const SizedBox(height: 16),
        Text(
          "Industry",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        CustomInputSelectionButton(
          hasSelected: creatingBusinessProfile.industry != null,
          onTap: () => _showBusinessCreationButtomSheet(
            title: "Industry",
            height: 500,
            dropdownItems: industries,
            selectItem: _selectIndustry,
            selectedItem: creatingBusinessProfile.industry,
          ),
          selectedItem: creatingBusinessProfile.industry != null
              ? creatingBusinessProfile.industry.toString()
              : "Choose all that apply",
        ),
        const SizedBox(height: 16),
        Text(
          "About business",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 200,
          child: TextField(
            controller: _aboutBusinessController,
            style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 14,
            ),
            maxLines: null,
            minLines: 10,
            decoration: InputDecoration(
              hintText: "Enter about your business",
              filled: true,
              fillColor: Colors.white,
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
              ref
                  .read(businessProfileProvider.notifier)
                  .updateBusinessProfile("aboutBusiness", value);
            },
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Business email address",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        EmailInput(
          controller: _emailController,
          bgColor: Colors.white,
          hideTopGap: true,
          onChange: _emailOnChangeHandler,
          key: const ValueKey("emailInput"),
          validator: _emailValidator,
        ),
        const SizedBox(height: 16),
        Text(
          "Phone number",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        PhoneInput(
          controller: _phoneNoController,
          validator: _phoneNumberValidator,
          onChange: _phoneNumberOnChangeHandler,
          bgColor: Colors.white,
          hideDropDownIcon: false,
          hideTopGap: true,
          selectCountry: _selectCountry,
          selectedCountryAcronym: creatingBusinessProfile
              .selectedPhoneNumberCountryDetails?.countryCode,
          selectedCountryFlag:
              creatingBusinessProfile.selectedPhoneNumberCountryDetails?.flag,
          selectedCountryPhoneCode: creatingBusinessProfile
              .selectedPhoneNumberCountryDetails?.phoneCode,
        ),
        const SizedBox(height: 16),
        Text(
          "Address",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _customColor.custom242424),
        ),
        const SizedBox(height: 9),
        CustomInputSelectionButton(
          hideTrailingIcon: true,
          selectedItem: creatingBusinessProfile.address != null
              ? creatingBusinessProfile.address!.locationName.toString()
              : "Enter your address",
          hasSelected: creatingBusinessProfile.address != null,
          onTap: () => _showAddressBottomSheet(
            searchInput: creatingBusinessProfile.address?.locationName,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Type in your address or triangulate to get the exact coordinates of your store/business location",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: _customColor.custom5D5D5D),
        ),
        const SizedBox(height: 16),
        Text(
          "Social media profiles",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _customColor.custom242424,
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: _tiktokController,
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Copy & paste URL",
            filled: true,
            fillColor: Colors.white,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 16, right: 8),
              child: Image.asset(
                "assets/icon/tiktok_black.png",
                height: 20,
                width: 20,
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
            ref.read(businessProfileProvider.notifier).updateBusinessProfile(
                  "tiktokUrl",
                  CommonType(
                    name: value.trim(),
                    imageUrl: "tiktok_black.png",
                  ),
                );
          },
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _twitterController,
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Copy & paste URL",
            filled: true,
            fillColor: Colors.white,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 16, right: 8),
              child: Image.asset(
                "assets/icon/twitter_black.png",
                height: 20,
                width: 20,
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
            ref.read(businessProfileProvider.notifier).updateBusinessProfile(
                  "twitterUrl",
                  CommonType(name: value.trim(), imageUrl: "twitter_black.png"),
                );
          },
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _instagramController,
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Copy & paste URL",
            filled: true,
            fillColor: Colors.white,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 16, right: 8),
              child: Image.asset(
                "assets/icon/instagram_black.png",
                height: 20,
                width: 20,
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
            ref.read(businessProfileProvider.notifier).updateBusinessProfile(
                  "instagramUrl",
                  CommonType(
                      name: value.trim(), imageUrl: "instagram_black.png"),
                );
          },
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _threadsController,
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Copy & paste URL",
            filled: true,
            fillColor: Colors.white,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 16, right: 8),
              child: Image.asset(
                "assets/icon/threads_black.png",
                height: 20,
                width: 20,
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
            ref.read(businessProfileProvider.notifier).updateBusinessProfile(
                  "threadsUrl",
                  CommonType(name: value.trim(), imageUrl: "threads_black.png"),
                );
          },
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _facebookController,
          style: TextStyle(
            color: _customColor.custom242424,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Copy & paste URL",
            filled: true,
            fillColor: Colors.white,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 150, maxWidth: 150),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 16, right: 8),
              child: Image.asset(
                "assets/icon/facebook_black.png",
                height: 20,
                width: 20,
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
            ref.read(businessProfileProvider.notifier).updateBusinessProfile(
                  "facebookUrl",
                  CommonType(
                      name: value.trim(), imageUrl: "facebook_black.png"),
                );
          },
        ),
        const SizedBox(height: 40),
        SaveBusinessProfileDetailsButton(
          isCreatedFromNewDeals: widget.isCreatedFromNewDeals,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
