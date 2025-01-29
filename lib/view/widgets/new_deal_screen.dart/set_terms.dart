import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tever/controller/new_deal_controller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/country.dart';
import 'package:tever/view/widgets/general/common/custom_input_selection_button.dart';
import 'package:tever/view/widgets/general/common/enter_address_labeled_text_field.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/terms_and_policy_bottom_sheet.dart';
import 'package:tever/view/widgets/new_deal_screen.dart/terms_and_policy_card.dart';
import 'package:tever/view/widgets/sign_up_screen/email_input.dart';
import 'package:tever/view/widgets/sign_up_screen/phone_input.dart';

class SetTerms extends ConsumerStatefulWidget {
  final Function next;
  final Function prev;
  const SetTerms({
    super.key,
    required this.next,
    required this.prev,
  });

  @override
  ConsumerState<SetTerms> createState() => _SetTermsState();
}

class _SetTermsState extends ConsumerState<SetTerms> {
  final CustomColors _customColor = const CustomColors();

  final TextEditingController _contactInfoAddressController =
      TextEditingController();

  final TextEditingController _contactInfoBrandNameController =
      TextEditingController();

  final TextEditingController _contactInfoAboutBrandController =
      TextEditingController();

  final TextEditingController _contactInfoPhoneNoController =
      TextEditingController();

  final TextEditingController _contactInfoEmailController =
      TextEditingController();

  int _selectedIndex = -1;

  //String? ,
  //String? ,
  //String? ,
  //bool? ,
  //String? ,

  void _contactInfoBrandNameOnChangeHandler(String value) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("contactInfoBrandName", value);
  }

  void _contactInfoAboutBrandOnChangeHandler(String value) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("contactInfoAboutBrand", value);
  }

  void _contactInfoAddressOnChangeHandler(String value) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("contactInfoAddress", value);
  }

  void _emailValidator(bool? hasError) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("contactInfoEmailError", hasError ?? false);
  }

  void _emailOnChangeHandler(String email) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("contactInfoEmail", email);
  }

  void _phoneNumberValidator(bool? hasError) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("contactInfoPhoneNumberError", hasError ?? false);
  }

  void _phoneNumberOnChangeHandler(String phoneNumber) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("contactInfoPhoneNumber", phoneNumber);
  }

  void _selectCountry(Country selectedCountry) {
    ref
        .read(newDealDataProvider.notifier)
        .updateNewDeal("contactInfoCountryFlag", selectedCountry.flag);
    ref.read(newDealDataProvider.notifier).updateNewDeal(
        "contactInfoCountryPhoneCode", selectedCountry.phoneCode);
    ref.read(newDealDataProvider.notifier).updateNewDeal(
        "contactInfoCountryAcronym", selectedCountry.countryCode);
  }

  void _showTermsAndPolicyBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const TermsAndPolicyBottomSheet();
      },
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newDealData = ref.watch(newDealDataProvider);

      _contactInfoAddressController.text = newDealData.contactInfoAddress ?? "";

      _contactInfoBrandNameController.text =
          newDealData.contactInfoBrandName ?? "";

      _contactInfoAboutBrandController.text =
          newDealData.contactInfoAboutBrand ?? "";

      _contactInfoPhoneNoController.text =
          newDealData.contactInfoPhoneNumber ?? "";

      _contactInfoEmailController.text = newDealData.contactInfoEmail ?? "";
    });
  }

  @override
  void dispose() {
    super.dispose();
    _contactInfoAddressController.dispose();

    _contactInfoAboutBrandController.dispose();

    _contactInfoBrandNameController.dispose();

    _contactInfoEmailController.dispose();

    _contactInfoPhoneNoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final newDealsData = ref.watch(newDealDataProvider);

    bool hasValidTermsAndPolicies =
        newDealsData.selectedTermsAndPolicy.isEmpty ||
            newDealsData.selectedTermsAndPolicy.any((document) =>
                document.title != "" ||
                document.title != null ||
                document.name != null ||
                document.doc != null);

    final isValid = !newDealsData.contactInfoEmailError! &&
        !newDealsData.contactInfoPhoneNumberError! &&
        newDealsData.contactInfoBrandName!.isNotEmpty &&
        newDealsData.contactInfoAboutBrand!.isNotEmpty &&
        newDealsData.contactInfoPhoneNumber!.isNotEmpty &&
        newDealsData.contactInfoEmail!.isNotEmpty &&
        newDealsData.contactInfoAddress!.isNotEmpty &&
        hasValidTermsAndPolicies;

    print(
        "chehchchchhcchch ${newDealsData.contactInfoPhoneNumber!.isNotEmpty}");

    return Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set terms and include your contact information",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: _customColor.custom242424),
            ),
            Column(children: [
              const SizedBox(height: 26),
              // Terms & policies
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = _selectedIndex == 0 ? -1 : 0;
                          });
                        },
                        child: Container(
                          height: 38,
                          color: Colors.transparent,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Terms & policies",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: _customColor.custom242424,
                                  ),
                                ),
                                AnimatedRotation(
                                  turns: _selectedIndex == 0 ? 0.5 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Image.asset(
                                    "assets/icon/drop_down.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      if (_selectedIndex == 0) const SizedBox(height: 10),
                      if (_selectedIndex == 0)
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Type",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: _customColor.custom242424),
                                ),
                                const SizedBox(height: 9),
                                CustomInputSelectionButton(
                                    selectedItem: "Choose an option!",
                                    hasSelected: false,
                                    onTap: _showTermsAndPolicyBottomSheet),
                                // TextFormField(
                                //   style: TextStyle(
                                //     color: _customColor.custom242424,
                                //     fontSize: 14,
                                //   ),
                                //   z
                                //   decoration: InputDecoration(
                                //     hintText: "Choose all that apply",
                                //     filled: true,
                                //     fillColor: Colors.white,
                                //     contentPadding: const EdgeInsets.all(16),
                                //     focusedBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(12),
                                //       borderSide: BorderSide(
                                //         color: _customColor.customEFEFEF,
                                //         width: 1,
                                //       ),
                                //     ),
                                //     suffixIconConstraints: const BoxConstraints(
                                //         maxHeight: 150, maxWidth: 150),
                                //     suffixIcon: Container(
                                //       margin: const EdgeInsets.only(right: 16),
                                //       child: Image.asset(
                                //         "assets/icon/drop_down.png",
                                //         height: 16,
                                //         width: 16,
                                //       ),
                                //     ),
                                //     enabledBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(12),
                                //       borderSide: BorderSide(
                                //         color: _customColor.customEFEFEF,
                                //         width: 1,
                                //       ),
                                //     ),
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(12),
                                //       borderSide: BorderSide(
                                //         color: _customColor.customEFEFEF,
                                //         width: 1,
                                //       ),
                                //     ),
                                //     errorBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(12),
                                //       borderSide: const BorderSide(width: 1),
                                //     ),
                                //     hintStyle: TextStyle(
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.w400,
                                //       color: _customColor.custom888888,
                                //     ),
                                //   ),
                                //   onChanged: (value) async {},
                                // ),
                                const SizedBox(height: 13),
                                if (newDealsData
                                    .selectedTermsAndPolicy.isNotEmpty)
                                  Column(
                                    children: newDealsData
                                        .selectedTermsAndPolicy
                                        .asMap()
                                        .entries
                                        .map((entry) => TermsAndPolicyCard(
                                            hideBottomBorder: entry.key ==
                                                newDealsData
                                                        .selectedTermsAndPolicy
                                                        .length -
                                                    1,
                                            title: entry.value.title.toString(),
                                            fileName: entry.value.name))
                                        .toList(),
                                  ),
                              ],
                            )),
                      const SizedBox(height: 7),
                      Divider(
                        color: _customColor.customEFEFEF,
                        thickness: 1,
                      )
                    ],
                  ),
                ),
              ),

              // Contact information
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = _selectedIndex == 1 ? -1 : 1;
                          });
                        },
                        child: Container(
                          height: 38,
                          color: Colors.transparent,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Contact information",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: _customColor.custom242424,
                                  ),
                                ),
                                AnimatedRotation(
                                  turns: _selectedIndex == 1 ? 0.5 : 1,
                                  duration: const Duration(milliseconds: 300),
                                  child: Image.asset(
                                    "assets/icon/drop_down.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      if (_selectedIndex == 1) const SizedBox(height: 10),
                      if (_selectedIndex == 1)
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Brand/business name",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: _customColor.custom242424),
                                ),
                                const SizedBox(height: 9),
                                TextField(
                                  controller: _contactInfoBrandNameController,
                                  style: TextStyle(
                                    color: _customColor.custom242424,
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Enter brand name",
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
                                  onChanged:
                                      _contactInfoBrandNameOnChangeHandler,
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  "About brand/ business name",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: _customColor.custom242424),
                                ),
                                const SizedBox(height: 9),
                                SizedBox(
                                  height: 120,
                                  child: TextField(
                                    controller:
                                        _contactInfoAboutBrandController,
                                    style: TextStyle(
                                      color: _customColor.custom242424,
                                      fontSize: 14,
                                    ),
                                    maxLines: null,
                                    minLines: 5,
                                    decoration: InputDecoration(
                                      hintText: "Enter description",
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
                                    onChanged:
                                        _contactInfoAboutBrandOnChangeHandler,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  "Phone number",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: _customColor.custom242424),
                                ),
                                const SizedBox(height: 9),
                                PhoneInput(
                                  controller: _contactInfoPhoneNoController,
                                  validator: _phoneNumberValidator,
                                  onChange: _phoneNumberOnChangeHandler,
                                  bgColor: Colors.white,
                                  hideDropDownIcon: false,
                                  hideTopGap: true,
                                  selectCountry: _selectCountry,
                                  selectedCountryAcronym:
                                      newDealsData.contactInfoCountryAcronym,
                                  selectedCountryFlag:
                                      newDealsData.contactInfoCountryFlag,
                                  selectedCountryPhoneCode:
                                      newDealsData.contactInfoCountryPhoneCode,
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  "Email address",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: _customColor.custom242424),
                                ),
                                const SizedBox(height: 9),
                                EmailInput(
                                  controller: _contactInfoEmailController,
                                  bgColor: Colors.white,
                                  hideTopGap: true,
                                  onChange: _emailOnChangeHandler,
                                  key: const ValueKey("emailInput"),
                                  validator: _emailValidator,
                                ),
                                const SizedBox(height: 22),
                                EnterAddressLabeledTextField(
                                  controller: _contactInfoAddressController,
                                  onChange: _contactInfoAddressOnChangeHandler,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Enter the address of your store/business location or tap or \"Use my current location\"",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: _customColor.custom242424),
                                ),
                                const SizedBox(height: 20),
                              ],
                            )),
                      Divider(
                        color: _customColor.customEFEFEF,
                        thickness: 1,
                      )
                    ],
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 183),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                        onPressed: () => widget.prev(1),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: theme.colorScheme.error, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.error,
                          ),
                        )),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => isValid ? widget.next(3) : null,
                      style: TextButton.styleFrom(
                        backgroundColor: isValid
                            ? theme.primaryColor
                            : _customColor.customD1D1D1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text(
                        "Post deal",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),
          ],
        ));
  }
}
