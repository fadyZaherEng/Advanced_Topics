import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static Init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData({
    String url = 'fcm/send',
    required String token,
    required String massage,
  }) {
    dio.options.headers = {
      'Authorization':
          "key=AAAAcgzqn38:APA91bGnOzX9QYPO4qXDMrHevdNU5Ts1dWwFMA04HlPyTPrAcQ4yhurtEUDKC8SZpfyZ2IHHauHQOYn0FwsM2lPJK6Y0Mo7s3uOnHlY_SuuSqulv1EvAl-wRFX_8H7ipqtwwSROPvwl4", //key server
      'Content-Type': 'application/json',
    };
    return dio.post(
      url,
      data: getData(token, massage),
    );
  }

  static Map<dynamic, dynamic> getData(token, String massage) {
    return {
      "to": token,
      "notification": {
        "title": "you have recieved a message from admin",
        "body": massage,
        "sound": "default"
      },
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default",
          "default_sound": true,
          "default_vibrate_timings": true,
          "default_light_settings": true
        }
      },
      "data": {
        "type": "order",
        "id": "87",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    };
  }
}
