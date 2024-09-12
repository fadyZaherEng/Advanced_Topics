import 'dart:convert';
//
// import 'package:city_eye/src/di/injector.dart';
// import 'package:city_eye/src/domain/usecase/save_firebase_notification_token_use_case.dart';
import 'package:huawei_push/huawei_push.dart';
import 'package:rxdart/rxdart.dart';

import 'notification_services.dart';

class HMSNotificationServices extends NotificationServices {
  String _token = "";

  static BehaviorSubject<String>? onNotificationClick;

  @override
  Future<void> initializeNotificationService() async {
    await Push.setAutoInitEnabled(true);

    Push.enableLogger();
    Push.turnOnPush();

    Push.getToken("");
    Push.getTokenStream.listen(
      _onTokenEvent,
    );
    onNotificationClick = BehaviorSubject<String>();

    Push.onNotificationOpenedApp.listen(
      _onNotificationOpenedApp,
    );

    var initialNotification = await Push.getInitialNotification();
    _onNotificationOpenedApp(initialNotification);

    Push.onMessageReceivedStream.listen(
      _onMessageReceived,
    );

    await Push.registerBackgroundMessageHandler(
      backgroundMessageCallback,
    );
  }

  void _onNotificationOpenedApp(dynamic remoteMessage) {
    if (remoteMessage != null) {
      Map<String, dynamic> remoteNotification = {
        "id": remoteMessage["extras"]['id'],
        "title": remoteMessage["extras"]['title'],
        "view": remoteMessage["extras"]['view'],
        "sectionid": remoteMessage["extras"]['sectionid'],
      };
      onNotificationClick?.add(json.encode(remoteNotification));
    }
  }

  static void backgroundMessageCallback(RemoteMessage remoteMessage) async {
    String? data = remoteMessage.data;

    Map<String, dynamic> remoteNotification = {
      "id": remoteMessage.dataOfMap?['id'],
      "title": remoteMessage.dataOfMap?['title'],
      "view": remoteMessage.dataOfMap?['view'],
      "sectionid": remoteMessage.dataOfMap?['sectionid'],
    };
    if (data != null) {
      onNotificationClick?.add(json.encode(remoteNotification));
    }
  }

  void _onMessageReceived(RemoteMessage remoteMessage) {
    String? data = remoteMessage.data;
    Map<String, dynamic> remoteNotification = {
      "id": remoteMessage.dataOfMap?['id'],
      "title": remoteMessage.dataOfMap?['title'],
      "view": remoteMessage.dataOfMap?['view'],
      "sectionid": remoteMessage.dataOfMap?['sectionid'],
    };
    if (data != null) {
      onNotificationClick?.add(json.encode(remoteNotification));
    }
  }

  void _onTokenEvent(Object event) async {
    _token = event.toString();
    // await SaveFirebaseNotificationTokenUseCase(injector())(
    //   firebaseNotificationToken: _token,
    // );
  }
}
