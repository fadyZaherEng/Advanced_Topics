import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service/new_with_hms/notification_services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:rxdart/rxdart.dart';
class FirebaseNotification {
  FirebaseNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

final didReceiveLocalNotificationSubject =
    BehaviorSubject<FirebaseNotification>();

class FirebaseNotificationService implements NotificationServices{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // static final onNotificationClick = BehaviorSubject<String?>();

  static BehaviorSubject<String>? onNotificationClick;

  String get androidNotificationChannelName => "Notification";

  String get androidNotificationChannelId => "Notification";

  @override
  Future<void> initializeNotificationService() async {
    NotificationSettings notificationSettings =
        await _setupNotificationPermission();
    _configMessage();

    String notificationToken = "";

    // if (notificationSettings.authorizationStatus ==
    //     AuthorizationStatus.authorized) {
    //   await SetNotificationsSwitchButtonValueUseCase(injector())(true);
    // } else if (notificationSettings.authorizationStatus ==
    //     AuthorizationStatus.provisional) {
    //   await SetNotificationsSwitchButtonValueUseCase(injector())(true);
    // } else if (notificationSettings.authorizationStatus ==
    //     AuthorizationStatus.denied) {
    //   await SetNotificationsSwitchButtonValueUseCase(injector())(false);
    // } else if (notificationSettings.authorizationStatus ==
    //     AuthorizationStatus.notDetermined) {
    //   await SetNotificationsSwitchButtonValueUseCase(injector())(false);
    // }


    // if (GetNotificationsSwitchButtonValueUseCase(injector())() == true) {
      try {
        notificationToken = await messaging.getToken() ?? "";
      } catch (e) {
        log(e.toString());
      }
      onNotificationClick = BehaviorSubject<String>();

      // await SaveFirebaseNotificationTokenUseCase(injector())(
      //   firebaseNotificationToken: notificationToken,
      // );
    // }

    if (kDebugMode) {
      log("MyToken: $notificationToken");
    }
  }

  FlutterLocalNotificationsPlugin get _getFlutterLocalNotificationsPlugin =>
      FlutterLocalNotificationsPlugin();

  Future<void> get _getFlutterLocalNotificationsPluginInitializer =>
      _getFlutterLocalNotificationsPlugin.initialize(_getInitializationSettings,
          onDidReceiveNotificationResponse: (notificationResponse) {
        onNotificationClick?.add(notificationResponse.payload ?? "");
      });

  AndroidInitializationSettings get _getAndroidInitializationSettings =>
      const AndroidInitializationSettings('@mipmap/ic_notification');

  final DarwinInitializationSettings _initializationSettingsIOS =
      DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
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

  InitializationSettings get _getInitializationSettings =>
      InitializationSettings(
          android: _getAndroidInitializationSettings,
          iOS: _initializationSettingsIOS);

  Future _setupNotificationPermission() async {
    return await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  NotificationDetails get _getNotificationDetails => NotificationDetails(
      android: _getAndroidNotificationDetails, iOS: _getIOSNotificationDetails);

  DarwinNotificationDetails get _getIOSNotificationDetails =>
      const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        presentBanner: true,
        presentList: true,
        sound: 'default',
      );

  AndroidNotificationDetails get _getAndroidNotificationDetails =>
      AndroidNotificationDetails(
        androidNotificationChannelId,
        androidNotificationChannelName,
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        channelShowBadge: true,
        enableLights: true,
        autoCancel: true,
        enableVibration: true,
        channelAction: AndroidNotificationChannelAction.createIfNotExists,
        icon: '@mipmap/ic_notification',
      );

  void _showNotificationAsLocal(
      {String? title, String? message, Map<String, dynamic>? data}) async {
    await _getFlutterLocalNotificationsPluginInitializer.whenComplete(() async {
      await _getFlutterLocalNotificationsPlugin.show(
          0, title, message, _getNotificationDetails,
          payload: json.encode(data));
    });
  }

  void _configMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      _setNotificationMessage(message, false);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      onNotificationClick?.add(json.encode(message.data));
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        onNotificationClick?.add(json.encode(message.data));
      }
    });
  }

  void _setNotificationMessage(RemoteMessage message, bool isBackGround) {
    _showNotificationAsLocal(
        data: message.data,
        message: message.notification!.body,
        title: message.notification!.title);
  }
}
