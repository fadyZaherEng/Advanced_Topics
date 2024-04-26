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
          "key=AAAAJPddWO0:APA91bHgIAwoFUvofx0OGP8p4tfHund2_ZE0IKaPZ0dE1fouhOrr0BKA0iusobQi32Skbe25Yz500bkmM5x4BqNBPVbgp_MATjuSMuYsJJiYu9Q3ZPTbuLpRTaznZHF6AzVQWMDZYCrv",
      //server key get from setting then cloud  massaging then make Cloud Messaging API (Legacy) enabled
      //by click on manage cloud messaging and make enabled then back to firebase and refresh
      //the server key appears
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
        "title": "you have received a message from admin",
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
