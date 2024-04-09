// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/show_massage_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/models.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_snack_bar_widget.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:permission_handler/permission_handler.dart';

// Add Events to device calender
// Update Events to device calender
// Remove Events to device calender
// Using device_Calender Package

class CalenderPropertyScreen extends StatefulWidget {
  const CalenderPropertyScreen({super.key});

  @override
  State<CalenderPropertyScreen> createState() => _CalenderPropertyScreenState();
}

class _CalenderPropertyScreenState extends State<CalenderPropertyScreen> {
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  String eventID = "";

  String calenderID = "";

  bool removeStatus = false;

  bool updateStatus = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                HomeEventItem? event = await _showCalenderActionDialog(
                    event: const HomeEventItem(
                  description: "Description 1",
                  locationAddress: "Location 1",
                  title: "Event 1",
                ));
                calenderID = event?.calenderRef ?? "";
                removeStatus = false;
                updateStatus = false;
                setState(() {});
              },
              child: const Text(
                "Add Event To Calender",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              eventID,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                removeStatus = await _deleteEventFromCalendar(
                  eventId: eventID,
                  calendarId: calenderID,
                );
                updateStatus = false;
                eventID = "";
                setState(() {});
              },
              child: const Text(
                "Remove Event From Calender",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              removeStatus == true
                  ? "Event Remove Status is: $removeStatus"
                  : "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                HomeEventItem eventModel = await _updateEventInCalender(
                    calenderId: calenderID,
                    event: HomeEventItem(
                      description: "Description 1",
                      locationAddress: "Location 1",
                      title: "Event 1",
                      endDate: "2023-10-23T04:00:00.000Z",
                      startDate: "2023-10-23T03:00:00.000Z",
                      calenderRef: eventID,
                    ));
                eventID = eventModel.calenderRef;
                removeStatus = false;
                updateStatus = true;
                setState(() {});
              },
              child: const Text(
                "Update Event From Calender",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              updateStatus == true
                  ? "Event Update Status is: $updateStatus"
                  : "Updated: $updateStatus",
              style: TextStyle(
                fontWeight:
                    updateStatus == false ? FontWeight.normal : FontWeight.bold,
                fontSize: updateStatus == false ? 14 : 16,
                color: updateStatus == false ? Colors.grey : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final cairoTimeZone = getLocation('Africa/Cairo');

  Future<HomeEventItem?> _showCalenderActionDialog(
      {required HomeEventItem event}) async {
    showActionDialogWidget(
      icon: ImagePaths.info,
      text: "do You Want To Add This Event To Your Device",
      primaryText: "yes",
      secondaryText: "no",
      context: context,
      primaryAction: () async {
        Navigator.pop(context);
        if (await PermissionServiceHandler().handleServicePermission(
            setting: PermissionServiceHandler.getCalendarPermission())) {
          return _handleAddEventToCalendar(event: event);
        } else {
          showActionDialogWidget(
            icon: ImagePaths.warning,
            context: context,
            primaryText: "ok",
            secondaryText: "cancel",
            text: "you Should Have Calendar Permission",
            primaryAction: () {
              Navigator.pop(context);
              openAppSettings().then((value) async {
                if ((await PermissionServiceHandler.getCalendarPermission()
                    .isGranted)) {
                  return _handleAddEventToCalendar(event: event);
                }
              });
            },
            secondaryAction: () {
              Navigator.pop(context);
            },
          );
        }
      },
      secondaryAction: () {
        Navigator.pop(context);
      },
    );
    return null;
  }

  Future<HomeEventItem> _handleAddEventToCalendar({
    required HomeEventItem event,
  }) async {
    HomeEventItem event = const HomeEventItem();
    TZDateTime? startDate = TZDateTime(
        cairoTimeZone,
        DateTime.parse(event.endDate).year,
        DateTime.parse(event.endDate).month,
        DateTime.parse(event.endDate).day,
        DateTime.parse(event.endDate).hour,
        0);
    TZDateTime? endDate = TZDateTime(
        cairoTimeZone,
        DateTime.parse(event.endDate).year,
        DateTime.parse(event.endDate).month,
        DateTime.parse(event.endDate).day,
        DateTime.parse(event.endDate).hour,
        0);
    bool isAllDay = false;
    final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    final calendarsResult = await deviceCalendarPlugin.retrieveCalendars();

    if (calendarsResult.isSuccess && calendarsResult.data!.isNotEmpty) {
      // ignore: prefer_typing_uninitialized_variables
      var foundCalendar;
      foundCalendar = calendarsResult.data!.first;

      if (foundCalendar != null) {
        calenderID = foundCalendar.id;

        try {
          var result = await _deviceCalendarPlugin.createOrUpdateEvent(Event(
            calenderID,
            title: event.title,
            location: event.locationAddress,
            description: event.description,
            allDay: isAllDay,
            start: startDate,
            end: endDate,
          ));

          if (result!.isSuccess) {
            event = event.copyWith(
              calenderRef: result.data!,
            );
            eventID = result.data!;
          } else {
            _showMassageDialogWidget(
                "Add Event Successfully", ImagePaths.error);
          }
        } catch (e) {
          _showMassageDialogWidget("failed To Add Event", ImagePaths.error);
        }
      } else {
        _showMassageDialogWidget("failed To Add Event", ImagePaths.warning);
      }
    } else {}

    return event;
  }

  Future<bool> _deleteEventFromCalendar({
    required String eventId,
    required String? calendarId,
  }) async {
    try {
      var result = await _deviceCalendarPlugin.deleteEvent(calendarId, eventId);
      if (result.isSuccess) {
        CustomSnackBarWidget.show(
          context: context,
          message: "Event Deleted Successfully",
          path: ImagePaths.success,
          backgroundColor: Colors.green,
        );
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<HomeEventItem> _updateEventInCalender({
    required HomeEventItem event,
    required String calenderId,
  }) async {
    if (event.calenderRef != "" && calenderId != "") {
      await _deviceCalendarPlugin
          .createOrUpdateEvent(
        Event(
          calenderId,
          title: event.title,
          description: event.description,
          start: TZDateTime.from(
            DateTime(2023, 10, 23, 4),
            getLocation(await FlutterNativeTimezone
                .getLocalTimezone()), //"Africa/Cairo",
          ),
          end: TZDateTime.from(
            DateTime(2023, 10, 23, 5),
            getLocation(await FlutterNativeTimezone
                .getLocalTimezone()), //"Africa/Cairo",
          ),
        ),
      )
          .then((result) async {
        if (result!.isSuccess) {
          final eventId = result.data;
          if (eventId != null) {
            _deleteEventFromCalendar(
              eventId: event.calenderRef,
              calendarId: calenderId,
            ).then((value) {
              event = event.copyWith(
                calenderRef: eventId,
              );
              if (value) {
                CustomSnackBarWidget.show(
                  context: context,
                  message: "Event Updated Successfully",
                  path: ImagePaths.success,
                  backgroundColor: Colors.green,
                );
              }
            }).catchError((onError) {
              print(onError.toString());
            });
          }
        }
      });
    }
    return event;
  }

  void _showMassageDialogWidget(String massage, String icon) {
    showMassageDialogWidget(
        icon: icon,
        text: massage,
        context: context,
        buttonText: "ok",
        onTap: () {
          Navigator.pop(context);
        });
  }
}
