import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tever/controller/new_event_controlller.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/coordinate.dart';
import 'package:tever/model/new_event.dart';
import 'package:tever/view/widgets/general/common/custom_input_selection_button.dart';
import 'package:tever/view/widgets/new_event_screen/address_list_bottom_sheet.dart';
import 'package:tever/view/widgets/new_event_screen/new_event_continue_button.dart';
import 'package:tever/view/widgets/new_event_screen/select_event_category_bottom_sheet.dart';
import 'package:tever/view/widgets/new_event_screen/select_event_type_bottom_sheet.dart';
import 'package:tever/view/widgets/new_event_screen/select_hosting_platform_botttom_sheet.dart';
import 'package:tever/view/widgets/new_event_screen/select_time_zone_bottom_sheet.dart';

class NewEventForm extends ConsumerStatefulWidget {
  final Function proceed;
  const NewEventForm({
    super.key,
    required this.proceed,
  });

  @override
  ConsumerState<NewEventForm> createState() => _NewEventFormState();
}

class _NewEventFormState extends ConsumerState<NewEventForm> {
  final CustomColors _customColor = const CustomColors();

  final TextEditingController _eventNameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _eventLinkController = TextEditingController();

  final TextEditingController _startTimeAndDateController =
      TextEditingController();

  final TextEditingController _endTimeAndDateController =
      TextEditingController();

  void _selectEventTypeBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const SelectEventTypeBottomSheet();
      },
    );
  }

  void _selectEventLocation({required Coordinate location}) {
    ref
        .read(newEventDataProvider.notifier)
        .updateNewEvent("addressOfEvent", location);
  }

  void _selectEventLocationBottomSheet({String? inputText}) {
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
          title: "Event Location",
          intialSearchInput: inputText,
          selectLocation: _selectEventLocation,
        );
      },
    );
  }

  void _selectHostingPlatformBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const SelectHostingPlatformBotttomSheet();
      },
    );
  }

  void _selectTimeZoneBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const SelectTimeZoneBottomSheet();
      },
    );
  }

  void _selectEventCategoryBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const SelectEventCategoryBottomSheet();
      },
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newEventData = ref.watch(newEventDataProvider);

      _eventNameController.text = newEventData.eventName;

      _descriptionController.text = newEventData.description;

      _eventLinkController.text = newEventData.eventLink;

      _startTimeAndDateController.text = newEventData.startTimeAndDate;

      _endTimeAndDateController.text = newEventData.endTimeAndDate;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _eventNameController.dispose();

    _descriptionController.dispose();

    _eventLinkController.dispose();

    _startTimeAndDateController.dispose();

    _endTimeAndDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newEventData = ref.watch(newEventDataProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Colors.white),
      child: Column(
        children: [
          const SizedBox(height: 9),
          TextField(
            controller: _eventNameController,
            style: TextStyle(
              color: _customColor.custom242424,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: "Event name",
              contentPadding: const EdgeInsets.only(left: 16, right: 16),
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
                  .read(newEventDataProvider.notifier)
                  .updateNewEvent("eventName", value);
            },
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: _customColor.customE7E7E7,
                )),
            child: Column(children: [
              Stack(
                children: [
                  SizedBox(
                    height: 140,
                    child: TextField(
                      controller: _descriptionController,
                      style: TextStyle(
                        color: _customColor.custom242424,
                        fontSize: 14,
                      ),
                      maxLines: null,
                      minLines: 5,
                      maxLength: 150,
                      buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              maxLength}) =>
                          null,
                      decoration: InputDecoration(
                        hintText: "Enter description",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _customColor.custom888888,
                        ),
                      ),
                      onChanged: (value) {
                        ref
                            .read(newEventDataProvider.notifier)
                            .updateNewEvent("description", value);
                      },
                    ),
                  ),
                  Positioned(
                      right: 16,
                      bottom: 14,
                      child: Text(
                        "${newEventData.description.length}/150 words",
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: _customColor.customB0B8C3),
                      ))
                ],
              ),
            ]),
          ),
          const SizedBox(height: 16),
          CustomInputSelectionButton(
              selectedItem: newEventData.eventType != null
                  ? newEventData.eventType!.name.toString()
                  : "Event type",
              hasSelected: newEventData.eventType != null,
              onTap: _selectEventTypeBottomSheet),
          const SizedBox(height: 16),
          if (newEventData.eventType != null)
            if (newEventData.eventType!.name == newEventType[1].name) ...[
              CustomInputSelectionButton(
                  selectedItem: newEventData.hostingPlatform != null
                      ? newEventData.hostingPlatform!.name.toString()
                      : "Hosting Platform",
                  hasSelected: newEventData.hostingPlatform != null,
                  onTap: _selectHostingPlatformBottomSheet),
              const SizedBox(height: 16),
            ],
          if (newEventData.eventType != null)
            if (newEventData.eventType!.name == newEventType[0].name) ...[
              CustomInputSelectionButton(
                hideTrailingIcon: true,
                imageUrl: "assets/icon/location_gray.png",
                selectedItem: newEventData.addressOfEvent != null
                    ? newEventData.addressOfEvent!.locationName.toString()
                    : "Enter address of the event",
                hasSelected: newEventData.addressOfEvent != null,
                onTap: () => _selectEventLocationBottomSheet(
                  inputText: newEventData.addressOfEvent?.locationName,
                ),
              ),
              const SizedBox(height: 16),
            ],
          if (newEventData.eventType != null)
            if (newEventData.eventType!.name == newEventType[1].name) ...[
              TextField(
                controller: _eventLinkController,
                style: TextStyle(
                  color: _customColor.custom242424,
                  fontSize: 14,
                ),
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: "Event link",
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
                  prefixIconConstraints:
                      const BoxConstraints(maxHeight: 150, maxWidth: 150),
                  prefixIcon: Container(
                    margin: const EdgeInsets.only(left: 16, right: 8),
                    child: Image.asset(
                      "assets/icon/link.png",
                      height: 16,
                      width: 16,
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
                      .read(newEventDataProvider.notifier)
                      .updateNewEvent("eventLink", value);
                },
              ),
              const SizedBox(height: 16),
            ],
          CustomInputSelectionButton(
              imageUrl: "assets/icon/global.png",
              selectedItem: newEventData.timeZone != null
                  ? newEventData.timeZone.toString()
                  : "Select timezone",
              hasSelected: newEventData.timeZone != null,
              onTap: _selectTimeZoneBottomSheet),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.only(top: 6, bottom: 6, left: 2),
            decoration: BoxDecoration(
                border: Border.all(
                  color: _customColor.customEFEFEF,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                SizedBox(
                  width: 48,
                  height: 96,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _customColor.customD1D1D1,
                        ),
                      ),
                      Image.asset(
                        "assets/image/line.png",
                        height: 45,
                        width: 1.5,
                      ),
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.5,
                            color: _customColor.customD1D1D1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: _startTimeAndDateController,
                        style: TextStyle(
                          color: _customColor.custom242424,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: "Start time and date",
                          contentPadding: const EdgeInsets.only(
                              top: 16, bottom: 16, right: 16),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: _customColor.customEFEFEF,
                              width: 1,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: _customColor.customEFEFEF,
                              width: 1,
                            ),
                          ),
                          border: UnderlineInputBorder(
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
                              .read(newEventDataProvider.notifier)
                              .updateNewEvent("startTimeAndDate", value);
                        },
                      ),
                      TextField(
                        controller: _endTimeAndDateController,
                        style: TextStyle(
                          color: _customColor.custom242424,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: "End time and date",
                          contentPadding: const EdgeInsets.only(
                              top: 16, bottom: 16, right: 16),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
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
                              .read(newEventDataProvider.notifier)
                              .updateNewEvent("endTimeAndDate", value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CustomInputSelectionButton(
              selectedItem: newEventData.eventCategory != null
                  ? newEventData.eventCategory!.name.toString()
                  : "Event category (optional)",
              hasSelected: newEventData.eventCategory != null,
              onTap: _selectEventCategoryBottomSheet),
          const SizedBox(height: 40),
          NewEventContinueButton(
            type: newEventData.eventType?.name,
            proceed: widget.proceed,
          )
        ],
      ),
    );
  }
}
