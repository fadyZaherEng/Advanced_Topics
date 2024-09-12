import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service/new_with_hms/firebase_notification_services.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service/new_with_hms/hms_notification_service.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service/notification_services.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notificationListener();
  }
  void _notificationListener() async {
    final int resultCode = await HmsApiAvailability().isHMSAvailableWithApkVersion(28);

    if (Platform.isAndroid) {
      if (resultCode == 1) {
        FirebaseNotificationService.onNotificationClick?.stream.listen((event) {
          if (event.isNotEmpty) {
            _onNotificationClick(event);
          }
        });
      } else {
        HMSNotificationServices.onNotificationClick?.stream.listen((event) {
          if (event.isNotEmpty) {
            _onNotificationClick(event);
          }
        });
      }
    } else if (Platform.isIOS) {
      FirebaseNotificationService.onNotificationClick?.stream.listen((event) {
        if (event.isNotEmpty) {
          _onNotificationClick(event);
        }
      });
    }
  }

  void _onNotificationClick(String? notificationData) async {
    FirebaseNotificationData firebaseNotificationData =
    mapNotification(notificationData);
    // final userUnit= GetUserUnitUseCase(injector())();
    // final user = GetUserInformationUseCase(injector())();
    // bool isUnitExist = false;
    //
    // for (int i = 0; i < user.userUnits.length; i++) {
    //   if (user.userUnits[i].unitId == firebaseNotificationData.unitId) {
    //     isUnitExist = true;
    //     break;
    //   }
    // }
    //
    // if (isUnitExist) {
    //   if (userUnit.unitId == firebaseNotificationData.unitId) {
         _checkNotificationStatus(firebaseNotificationData);
    //   } else {
    //     // ignore: await_only_futures
    //     final user = await GetUserInformationUseCase(injector()).call();
    //     for (int i = 0; i < user.userUnits.length; i++) {
    //       if (user.userUnits[i].unitId == firebaseNotificationData.unitId) {
    //         await SetSwitchLogoUseCase(injector())(
    //             user.userUnits[i].compoundLogo);
    //         await SetUserUnitUseCase(injector())(user.userUnits[i])
    //             .then((value) =>
    //         {
    //           _restartApp(value),
    //         });
    //         break;
    //       }
    //     }
    //   }
    // } else {
       await _sendEmptyEventToStream();
    //   await SetRememberMeUseCase(injector())(false);
    //   await RemoveUserInformationUseCase(injector())();
    //   await RemoveUserUnitsUseCase(injector())().then((value) =>
    //       Navigator.pushNamedAndRemoveUntil(
    //           context, Routes.splash, (route) => false));
    // }
  }

  void _checkNotificationStatus(
      FirebaseNotificationData firebaseNotificationData) async {
    // if (firebaseNotificationData.code == "general") {
    //   if (firebaseNotificationData.message.isNotEmpty) {
    //     _showMassageDialogWidget(
    //       firebaseNotificationData.message,
    //       ImagePaths.logo,
    //     );
    //   }
    // } else if (firebaseNotificationData.code == "notificationDetails") {
    //   _navigateToNotificationDetailsScreen(firebaseNotificationData.id);
    // } else if (firebaseNotificationData.code == "eventDetails") {
    //   _navigateToEventDetailsScreen(firebaseNotificationData.id);
    // } else if (firebaseNotificationData.code == "surveys") {
    //   Navigator.pushNamed(context, Routes.surveys, arguments: {
    //     "id": firebaseNotificationData.id,
    //   });
    // } else if (firebaseNotificationData.code == "qrDetails") {
    //   _navigateToQrDetailsScreen(firebaseNotificationData.id);
    // } else if (firebaseNotificationData.code == "current_qrHistory") {
    //   // Note : first list item is for scroll item Id
    //   // and second list item is for go to History
    //   // and third list item is for go to current or previous
    //   await SetQrCodeIndexUseCase(injector())(
    //       [firebaseNotificationData.id.toString(), "1", "0"]).then((value) {
    //     _navigateToQrHistory();
    //   });
    // } else if (firebaseNotificationData.code == "previous_qrHistory") {
    //   // Note : first list item is for scroll item Id
    //   // and second list item is for go to History
    //   // and third list item is for go to current or previous
    //   await SetQrCodeIndexUseCase(injector())(
    //       [firebaseNotificationData.id.toString(), "1", "1"]).then((value) {
    //     _navigateToQrHistory();
    //   });
    // } else if (firebaseNotificationData.code == "open_support") {
    //   // Note : first list item is for scroll item Id
    //   // and second list item is for go to History
    //   // and third list item is for go to open requests or all requests
    //   await SetSupportIndexUseCase(injector())(
    //       [firebaseNotificationData.id.toString(), "1", "open_support"])
    //       .then((value) {
    //     _selectedIndex = 1;
    //     Navigator.popUntil(context, (route) => route.isFirst);
    //   });
    // } else if (firebaseNotificationData.code == "all_support") {
    //   // Note : first list item is for scroll item Id
    //   // and second list item is for go to History
    //   // and third list item is for go to open requests or all requests
    //   await SetSupportIndexUseCase(injector())(
    //       [firebaseNotificationData.id.toString(), "1", "all_support"])
    //       .then((value) {
    //     _selectedIndex = 1;
    //     Navigator.popUntil(context, (route) => route.isFirst);
    //   });
    // } else if (firebaseNotificationData.code == "support_completed") {
    //   // Note : first list item is for scroll item Id
    //   // and second list item is for go to History
    //   // and third list item is for go to open requests or all requests
    //   await SetSupportIndexUseCase(injector())([
    //     firebaseNotificationData.id.toString(),
    //     "1",
    //     "support_completed"
    //   ]).then((value) {
    //     _selectedIndex = 1;
    //     Navigator.popUntil(context, (route) => route.isFirst);
    //   });
    // } else if (firebaseNotificationData.code == "wall") {
    //   await SetWallItemIdUseCase(injector())(firebaseNotificationData.id)
    //       .then((value) {
    //     _selectedIndex = 2;
    //     Navigator.popUntil(context, (route) => route.isFirst);
    //   });
    // } else if (firebaseNotificationData.code == "users-myBookings") {
    //   await SetServicesIndexUseCase(injector())(firebaseNotificationData.id)
    //       .then((value) {
    //     _selectedIndex = 3;
    //     //Navigator.popUntil(context, (route) => route.isFirst);
    //   });
    // } else if (firebaseNotificationData.code == "gallery") {
    //   Navigator.pushNamed(context, Routes.gallery, arguments: {
    //     "id": firebaseNotificationData.id,
    //   });
    // } else if (firebaseNotificationData.code == "paymentDetails") {
    //   // Navigator.of(context).pushNamedIfNotCurrent(
    //   //     context: context,
    //   //     Routes.paymentDetails,
    //   //     arguments: {
    //   //       "paymentId": firebaseNotificationData.id,
    //   //     });
    //   // _scaffoldKey.currentState?.context
    //   //     .findAncestorStateOfType<NavigatorState>()
    //   //     ?.popUntil((route) {
    //   //   print("rrrrrrrrrrrrrr${route.settings.name}");
    //   //   return true;
    //   // });
    //   GetPaymentDetailsStatusUseCase(injector()).call().then((value) {
    //     if (!value) {
    //       Navigator.pushNamed(context, Routes.paymentDetails, arguments: {
    //         "paymentId": firebaseNotificationData.id,
    //       });
    //     }
    //   });
    // } else if (firebaseNotificationData.code == "events") {
    //   Navigator.pushNamed(context, Routes.events, arguments: {
    //     "id": firebaseNotificationData.id,
    //   });
    // } else if (firebaseNotificationData.code == "notifications") {
    //   Navigator.pushNamed(context, Routes.notifications, arguments: {
    //     "id": firebaseNotificationData.id,
    //   });
    // } else if (firebaseNotificationData.code == "familymember") {
    //   Navigator.pushNamed(context, Routes.profile, arguments: {
    //     "index": 4,
    //     "scrollToId": firebaseNotificationData.id,
    //   });
    // } else if (firebaseNotificationData.code == "support_comments") {
    //   Navigator.pushNamed(context, Routes.commentScreen, arguments: {
    //     'order': const Orders(),
    //     "id": firebaseNotificationData.id,
    //   });
    // } else if (firebaseNotificationData.code == "UnitContract") {
    //   Navigator.pushNamed(context, Routes.profile, arguments: {
    //     "index": 3,
    //     "scrollToId": firebaseNotificationData.id,
    //   });
    // }
    // await _sendEmptyEventToStream();
    // setState(() {});
  }

  Future<void> _sendEmptyEventToStream() async {
    final int resultCode =
    await HmsApiAvailability().isHMSAvailableWithApkVersion(28);
    if (Platform.isAndroid) {
      if (resultCode == 1) {
        FirebaseNotificationService.onNotificationClick?.add("");
      } else {
        HMSNotificationServices.onNotificationClick?.add("");
      }
    } else if (Platform.isIOS) {
      FirebaseNotificationService.onNotificationClick?.add("");
    }
  }

  FirebaseNotificationData mapNotification(String? notificationData) {
    Map<String, dynamic> mapDate = json.decode(notificationData!);
    FirebaseNotificationData model = FirebaseNotificationData.fromJson(mapDate);

    return model;
  }
}
