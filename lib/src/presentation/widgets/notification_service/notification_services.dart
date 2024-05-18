// ignore_for_file: unused_element, depend_on_referenced_packages

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final didReceiveLocalNotificationSubject =
    BehaviorSubject<FirebaseNotification>();

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final onNotificationClick = BehaviorSubject<String?>();

  String get androidNotificationChannelName => "Notification";

  String get androidNotificationChannelId => "Notification";

  Future<void> initializeNotificationService() async {
    await _setupNotificationPermission();
    _configMessage();
    String notificationToken = await messaging.getToken() ?? "";

    if (kDebugMode) {
      print("MyToken $notificationToken");
    }

    await SaveFirebaseNotificationTokenUseCase(injector())(
        firebaseNotificationToken: notificationToken);
  }

  FlutterLocalNotificationsPlugin get _getFlutterLocalNotificationsPlugin =>
      FlutterLocalNotificationsPlugin();

  Future<void> get _getFlutterLocalNotificationsPluginInitializer =>
      _getFlutterLocalNotificationsPlugin.initialize(_getInitializationSettings,
          onDidReceiveNotificationResponse: (notificationResponse) {
        onNotificationClick.add(notificationResponse.payload);
      });

  AndroidInitializationSettings get _getAndroidInitializationSettings =>
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings _initializationSettingsIOS =
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

  InitializationSettings get _getInitializationSettings =>
      InitializationSettings(
          android: _getAndroidInitializationSettings,
          iOS: _initializationSettingsIOS);

  Future _setupNotificationPermission() async {
    await messaging.requestPermission(
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
      const DarwinNotificationDetails();

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
        icon: '@mipmap/ic_launcher',
      );

  void _showNotificationAsLocal({
    String? title,
    String? message,
    Map<String, dynamic>? data,
  }) async {
    await _getFlutterLocalNotificationsPluginInitializer.whenComplete(() async {
      await _getFlutterLocalNotificationsPlugin.show(
        0,
        title,
        message,
        _getNotificationDetails,
        payload: json.encode(data),
      );
    });
  }
  // https://pub.dev/packages/firebase_messaging/example
  //
  // In this there are how to add subscribe and in subscribe
  // And different between three methods
  // On massage call when background or app closed
  // Get initial
  // عند تعريف firebase massage
  // On massage Open app
  // وهو مفتوح
  // لذلك في الفتح أو التعريف بضيف في المتغير بس وهو في ال main بي listen فينقل لوحده
  // إنما
  // في ال background or closed
  // بعرض فقط وكده كده في ال did receive بيحصلها call بضيف فيه فبتتغير ال قيمه لوحدها ولما اضغط عليه هيدخل وهيلاقي في قيمه
  // دا كده ال سينيور

  void _configMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      _setNotificationMessage(message, false);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      onNotificationClick.add(json.encode(message.data));
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        onNotificationClick.add(json.encode(message.data));
      }
    });
  }

  void _setNotificationMessage(RemoteMessage message, bool isBackGround) {
    _showNotificationAsLocal(
      data: message.data,
      message: message.notification?.body ?? "",
      title: message.notification?.title ?? "",
    );
  }
}

class SaveFirebaseNotificationTokenUseCase {
  final SharedPreferences _sharedPreferences;

  SaveFirebaseNotificationTokenUseCase(this._sharedPreferences);

  Future<bool> call({required String firebaseNotificationToken}) async {
    return await _sharedPreferences.setString(
            "token", firebaseNotificationToken) ??
        false;
  }
}

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

class FirebaseNotificationData {
  final String message;
  final String code;
  final int id;

  FirebaseNotificationData({
    required this.message,
    required this.code,
    required this.id,
  });

  factory FirebaseNotificationData.fromJson(Map<String, dynamic> json) {
    return FirebaseNotificationData(
      id: int.parse(json['id']),
      message: json['title'] ?? "",
      code: json['view'] ?? "",
    );
  }

  @override
  String toString() {
    return 'FirebaseNotificationData{message: $message, code: $code, id: $id}';
  }
}

//call this in init state of main screen
void _notificationListener() {
  NotificationService.onNotificationClick.stream.listen((event) {
    _onNotificationClick(event);
  });
}

void _onNotificationClick(String? notificationData) {
  FirebaseNotificationData firebaseNotificationData =
      mapNotification(notificationData);

  if (firebaseNotificationData.code == "general") {
    //_showMassageDialogWidget(firebaseNotificationData.message);
  } else if (firebaseNotificationData.code == "qrDetails") {
    //_navigateToQrDetailsScreen(firebaseNotificationData.id);
  } else if (firebaseNotificationData.code == "support_comments") {
    // Navigator.pushNamed(context, Routes.comments,
    //     arguments: firebaseNotificationData.id);
  } else if (firebaseNotificationData.code == "supportDetails") {
    //_navigateToJobDetailsScreen(firebaseNotificationData.id);
  } else if (firebaseNotificationData.code == "notifications") {
    //_navigateToNotificationsScreen(firebaseNotificationData.id);
  } else if (firebaseNotificationData.code == "notificationsDetails") {
    //_navigateToNotificationsDetailsScreen(firebaseNotificationData.id);
  } else if (firebaseNotificationData.code == "TechUnitsQr") {
    // _bloc.add(
    //   NavigateBetweenScreensEvent(
    //     position: 0,
    //   ),
    // );
    // Navigator.popUntil(context, (route) => route.isFirst);
  }

  NotificationService.onNotificationClick.add("");
}

FirebaseNotificationData mapNotification(String? notificationData) {
  Map<String, dynamic> mapDate = json.decode(notificationData!);
  FirebaseNotificationData model = FirebaseNotificationData.fromJson(mapDate);

  return model;
}
