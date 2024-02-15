// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service_with_fcm_rest_api/notification_service/firebase_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final didReceiveLocalNotificationSubject =
    BehaviorSubject<FirebaseNotification>();

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static AndroidInitializationSettings get _getAndroidInitializationSettings =>
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  static DarwinNotificationDetails get _getIOSNotificationDetails =>
      const DarwinNotificationDetails();

  static AndroidNotificationDetails get _getAndroidNotificationDetails =>
      const AndroidNotificationDetails(
        "Notification",
        "Notification",
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        channelShowBadge: true,
        enableLights: true,
        autoCancel: true,
        enableVibration: true,
        channelAction: AndroidNotificationChannelAction.createIfNotExists,
        icon: '@mipmap/ic_launcher',
      );

  static final DarwinInitializationSettings _initializationSettingsIOS =
      DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: true,
          requestSoundPermission: false,
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {
            didReceiveLocalNotificationSubject.add(
              FirebaseNotification(
                id: id,
                title: title,
                body: body,
                payload: payload,
              ),
            );
          });

  static InitializationSettings get _getInitializationSettings =>
      InitializationSettings(
          android: _getAndroidInitializationSettings,
          iOS: _initializationSettingsIOS);

  static Future<void> get _getFlutterLocalNotificationsPluginInitializer =>
      _notificationsPlugin.initialize(_getInitializationSettings,
          onDidReceiveNotificationResponse: (notificationResponse) {});

  static Future<void> initializeNotificationService() async {
    await _setupNotificationPermission();
    await callFirebaseMassaging();
  }

  static Future _setupNotificationPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static NotificationDetails get _getNotificationDetails => NotificationDetails(
      android: _getAndroidNotificationDetails, iOS: _getIOSNotificationDetails);

  static Future _showNotification(RemoteMessage message) async {
    await _getFlutterLocalNotificationsPluginInitializer
        .whenComplete(() async => await _notificationsPlugin.show(
              0,
              message.notification!.title,
              message.notification!.body,
              _getNotificationDetails,
              payload: json.encode(message.data),
            ));
  }

  static Future<void> firebaseMassageBackground(RemoteMessage message) async {
    _showNotification(message);
  }

  static Future<void> callFirebaseMassaging() async {
    var token = await FirebaseMessaging.instance.getToken();
    print("token:$token \n");
    //first method
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _showNotification(message);
    });
    //second method
    FirebaseMessaging.onBackgroundMessage(firebaseMassageBackground);
    //third method
    FirebaseMessaging.onMessage.listen((message) {
      _showNotification(message);
    });
  }
}
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// //another way to display notification faster
// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   static Future<void> initialize() async {
//     AndroidInitializationSettings androidInitializationSettings =
//         const AndroidInitializationSettings(
//       '@mipmap/ic_launcher',
//     );
//
//     DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification: (
//         id,
//         title,
//         body,
//         payload,
//       ) {},
//     );
//     InitializationSettings initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosSettings,
//     );
//     await _notificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (
//         details,
//       ) {},
//     );
//   }
//
//   //
//   // static Future<void> bigPictureDisplay(RemoteMessage message) async {
//   //   BigPictureStyleInformation bigPictureStyleInformation=const BigPictureStyleInformation(
//   //     DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
//   //     largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
//   //   );
//   //   AndroidNotificationDetails androidNotificationDetails =
//   //    const AndroidNotificationDetails(
//   //     "channelId",
//   //     "channelName",
//   //     priority: Priority.high,
//   //     importance: Importance.max,
//   //      icon:'@mipmap/ic_launcher',
//   //     channelShowBadge: true,
//   //     largeIcon: DrawableResourceAndroidBitmap(
//   //       '@mipmap/ic_launcher',
//   //     ),
//   //   );
//   //   NotificationDetails notificationDetails = NotificationDetails(
//   //     android: androidNotificationDetails,
//   //   );
//   //   await _notificationsPlugin.show(
//   //     0,
//   //     message.notification!.title,
//   //     message.notification!.body,
//   //     notificationDetails,
//   //   );
//   // }
//   static Future<void> display(RemoteMessage message) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         const AndroidNotificationDetails(
//       "channelId",
//       "channelName",
//       priority: Priority.high,
//       importance: Importance.max,
//       icon: '@mipmap/ic_launcher',
//       channelShowBadge: true,
//       largeIcon: DrawableResourceAndroidBitmap(
//         '@mipmap/ic_launcher',
//       ),
//     );
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );
//     await _notificationsPlugin.show(
//       0,
//       message.notification!.title,
//       message.notification!.body,
//       notificationDetails,
//     );
//   }
//
//   static Future<void> firebaseMassageBackground(RemoteMessage message) async {
//     LocalNotificationService.display(message);
//   }
//
//   static Future<void> callFirebaseMassaging() async {
//     var token = await FirebaseMessaging.instance.getToken();
//     print("token:$token \n");
//     //first method
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       LocalNotificationService.display(message);
//     });
//     //second method
//     FirebaseMessaging.onBackgroundMessage(await firebaseMassageBackground);
//     //third method
//     FirebaseMessaging.onMessage.listen((message) {
//       LocalNotificationService.display(message);
//     });
//   }
// }
