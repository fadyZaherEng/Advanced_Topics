// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

class SendNotificationService {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/v1/projects/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData({
    String projectId = "303235547553",
    required String requestId,
    required String message,
  }) async {
    //TODO Get the access token
    final accessToken = await getServerAccessToken();
    if (accessToken != null) {
      print('Access Token: $accessToken');
    } else {
      print('Failed to generate access token.');
    }

    String url = '$projectId/messages:send';
    dio.options.headers = {
      'Authorization':
      'key =ya29.c.c0ASRK0Gb4AW2fI-Pwa6shWGzpzwrdzTqz8pXLa1-o12jZgG2sjMw2OFoBi0TbSniDMNZy7-84BMzAdfnpa9EchVDO1FqKy2IXaDK3apUC4eTHUQ1OPFL1R8TNf8y-nDw-PHfzF31O6qDTuTyj4WGtZRu94wn0XO1xhCrU39a04HfOtlTqyQdQ5QkEFf33M1y_AHlXZcx2NWWeQ9qT8n_gKEfHxpuNy7UHS0hvDGRUn0DoYQhOnZWyIt2rUdSsEDtakmhQUfca3sjjC8YKxlpf8rFJWCLfUU-LBrkfYltwFZfEtwtZhM6UTbPkW2mpwgUT0r50GIQoMV3NHEcVGaE3isgjCiM65Rgy643t0D7d_1kkl4aP-CswjsHVcWYH1BNLDygb2QL399AQ1bZRXrr56qXpW91JpYnIf3rZJnbfBseblv7InYxXeumISOJ7twnJgmRWxM8iQd0u7ZqefgJBfMF8-dRnWtXwpquyiQnF-z8sy780M638-J8yFJf4WYU74k526Qm4qIZim3t0llUmbwbtaOauYFjBpjvaheQOZe1tFdVhns4U_j0ear8x9kftvQWYoSUSJwynnoks_tvoMfMd49wmqm41ZorMbWMQZRfakuWS67zbacYIrnrYd9zJYW-60mdeqjvxMgVlBZR6Qjg1FU5i-b8eWUmdj2ux9dMeVWvyUb9dgfVSU5tXynBtnhuio6u-WhZoehFOcgmifWsXua-hQMJp3yxQpftlJoFOVxiQXk9pmzVbmhbUkf9sfkJYgg-zlaayl3_aZkWq2j6xBre762O62SISqZsy8JeerU2OSFI_MWmhmSgvfsp5wIWkBIrqzF1Fr3dp9ezito9BoI92xlYkooxZn4yj-gSbRq6iVq76JpWzM7OU-MSv0Fseyi52iXMu9Qe2cwJlzukvZabfz1w4s9e4QSXeMpcUoBhOg7--h91zvyoBMxOJa33WRhXbv4YIkij32O8W35ntytgbmjkfuXb8kpc4F3o6O161-Xxo1yQ',
      'Content-Type': 'application/json',
    };
    return await dio.post(
      url,
      data: _getBodyHeader(requestId, message),
    );
  }

  static Future<String?> getServerAccessToken() async {
    // Path to your Service Account JSON key file
    const serviceAccountPath =
        'lib/src/presentation/widgets/notification_service/notification_service_with_fcm_rest_api/service_key.json';

    // Load the service account key JSON file
    final serviceAccountJson =
    json.decode(File(serviceAccountPath).readAsStringSync());

    final clientEmail = serviceAccountJson['client_email'];
    final privateKey = serviceAccountJson['private_key'];

    // The scope required for FCM
    const fcmScope = 'https://www.googleapis.com/auth/firebase.messaging';

    // Generate the credentials
    final credentials = ServiceAccountCredentials(
      clientEmail,
      privateKey,
      fcmScope, // Add scopes as a list here
    );

    // Request the access token
    final client = http.Client();
    final authClient = await clientViaServiceAccount(credentials, [fcmScope],
        baseClient: client);

    final accessToken = authClient.credentials.accessToken.data;

    // Close the HTTP client
    authClient.close();
    return accessToken;
  }

  static Map<String, dynamic> _getBodyHeader(String requestId, String message) {
    // return {
    //   // "to": Use "/topics/<request_id>" for topic-based messaging
    //   "to": "/topics/$requestId",
    //   // "token":
    //   //     "dUMSP-ZqTnCYBEXfLjT141:APA91bELI6c5xqh3FHGb0elM84J3AfuSzU2h93Ej4q0vxFHrzCY_NgEJD4dIyqTp7REsrilna6b9m7JBUYXDGjYNo1ZXElZNs_nYMwcydS2Ait7IbOlc84A",
    //
    //   "notification": {
    //     "title": "You have received a message from admin",
    //     "body": message,
    //     "sound": "default"
    //   },
    //   "android": {
    //     "priority": "HIGH",
    //     "notification": {
    //       "notification_priority": "PRIORITY_MAX",
    //       "sound": "default",
    //       "default_sound": true,
    //       "default_vibrate_timings": true,
    //       "default_light_settings": true
    //     }
    //   },
    //   "data": {
    //     "type": "order",
    //     "id": "87",
    //     "click_action": "FLUTTER_NOTIFICATION_CLICK"
    //   }
    // };
    return {
      "message": {
        // "token": "dj6lgablT_GYpv4M6ATsOI:APA91bFnAl9GWhia6w7fOTI6GtDAlzBc3993vVNypeOdIn92lsQ-y-c7IakUdwJPItkHFgA2oIw5AfW57O6Tngkqx7C3xjNbak3LBzDsjX5sgYdj-ogPikI",
        "topic": "223",
        "notification": {
          "title": "Test Notification",
          "body": "This is a test notification"
        }
      }
    };
  }

  static Future subscribeToGroup(String requestId, String userId) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(requestId);
      print("Subscribed to topic: $requestId");
    } catch (e) {
      print("Error subscribing to topic: $e");
    }
    // Save subscription info to Firestore
    FirebaseFirestore.instance.collection('subscriptions').doc(requestId).set({
      'userId': userId,
      'requestId': requestId,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print('Subscribed to $requestId and logged in Firestore.');
  }
}


