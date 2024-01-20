import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//another way to display notification
class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
        id,
        title,
        body,
        payload,
      ) {},
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosSettings,
    );
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (
        details,
      ) {},
    );
  }

  //
  // static Future<void> bigPictureDisplay(RemoteMessage message) async {
  //   BigPictureStyleInformation bigPictureStyleInformation=const BigPictureStyleInformation(
  //     DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
  //     largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
  //   );
  //   AndroidNotificationDetails androidNotificationDetails =
  //    const AndroidNotificationDetails(
  //     "channelId",
  //     "channelName",
  //     priority: Priority.high,
  //     importance: Importance.max,
  //      icon:'@mipmap/ic_launcher',
  //     channelShowBadge: true,
  //     largeIcon: DrawableResourceAndroidBitmap(
  //       '@mipmap/ic_launcher',
  //     ),
  //   );
  //   NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );
  //   await _notificationsPlugin.show(
  //     0,
  //     message.notification!.title,
  //     message.notification!.body,
  //     notificationDetails,
  //   );
  // }
  static Future<void> display(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "channelId",
      "channelName",
      priority: Priority.high,
      importance: Importance.max,
      icon: '@mipmap/ic_launcher',
      channelShowBadge: true,
      largeIcon: DrawableResourceAndroidBitmap(
        '@mipmap/ic_launcher',
      ),
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _notificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
    );
  }

  static Future<void> firebaseMassageBackground(RemoteMessage message) async {
    LocalNotificationService.display(message);
  }

  static Future<void> callFirebaseMassaging() async {
    var token = await FirebaseMessaging.instance.getToken();
    print("token:$token \n");
    //first method
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      LocalNotificationService.display(message);
    });
    //second method
    FirebaseMessaging.onBackgroundMessage(await firebaseMassageBackground);
    //third method
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(message);
    });
  }
}
