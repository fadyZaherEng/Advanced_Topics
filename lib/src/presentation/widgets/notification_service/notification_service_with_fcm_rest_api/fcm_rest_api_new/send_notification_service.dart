// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class SendNotificationService {
  static Future<void> sendMassageByToken({
    String projectId = "303235547553",
    required String requestId,
    required String message,
  }) async {
    final String serverAccessToken = await getServerAccessToken();
    print('Access Token: $serverAccessToken');
    String url =
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

    final currentFCMToken = await FirebaseMessaging.instance.getToken();
    final Map<String, dynamic> massage = {
      "message": {
        "token": "$currentFCMToken",
        "notification": {
          "title": "${'S.current.you'} have a new message on Request $requestId",
          "body": "This is a test notification"
        },
        'data': {
          "view": "support_comments",
          "id": requestId,
          'current_user_fcm_token': "$currentFCMToken",
        }
      }
    };
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $serverAccessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(massage),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification');
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  static Future<void> sendMassageByTopic({
    String projectId = "303235547553",
    required String requestId,
    required String topic,
    required String message,
    required int unitId,
  }) async {
    // TODO: Get the access token
    final String serverAccessToken = await getServerAccessToken();
    print('Access Token: $serverAccessToken');

    String url =
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

    final Map<String, dynamic> notificationMessage = {
      "message": {
        "topic": "topic$requestId", // Specify the topic instead of the token
        "notification": {
          "title": "${'S.current.you'} have a new message on Request $requestId",
          "body": message,
        },
        "data": {
          "view": "support_comments",
          "id": requestId,
          "sectionid": unitId.toString(),
          "request_id": requestId,
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $serverAccessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(notificationMessage),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully to topic: $topic');
    } else {
      print('Failed to send notification');
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  static Future<String> getServerAccessToken() async {
    // Path to your Service Account JSON key file
    const serviceAccountJson = {
      "type": "service_account",
      "project_id": "cityeye-7c456",
      "private_key_id": "6005ee74ec548e1d658be5be9118db7d3230c4f7",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCcomAnlo9l+TCf\nBDMHVp2XAr9qZP1oETJLEuB7PHjbVHG7TyDqxX+aptA0V35d3LtR/N4R64XCfFbh\nX4+xYc/FGXFFaQ8xMfbObZ6ONSXfoHDqbaZcvETVy9SSAdUayx1hfT8L2onJBQac\nbbUNZj/yeGtQM5U3mODFbKUr9sTVeedE4rM+dNdckyU/CVx8I1sOcEMKSsocH/+l\nvohw+5Rbfi/m70HmOU5mir793IHD0tjc14+UeBJhA4+UL+z/eXILMXliXWHh324n\n3OkdxNcm5Jc1qjjS98YcDXCP5aY1acunWB23kui0rg+3fgiTy9883XWzSQZyis6S\n7A9yB7bbAgMBAAECggEAORopG8WTuYVC6HXLdJ1rDiZ+SfdPOqUqRJw5IjRFixAZ\n9kM+qNgfUO4HcU2EUAusbpNVEgte1CwoMDl6VRxndl90H+3REAo7A76K0yUlDYWc\nJJqcz6oDHj4U3LW2TvJFX8kdNuEQ4ivm4RhNrPjdzzN/S9nCSGZ/avnUrVZlI72f\nFQg+lTQC4sXrUy+TVjKp8rspeuTVaAwPD1eLckg3M8WgGqpuu8QR82wljdXmKtRp\nPq9GCygogm6xbkTendt/wUZPK/VIBr4qSRynF/GI5TCZmKRfcYn50VxvgT0y1c5U\n1aw2LX+QyFIS/fqvrcbTHGVQCfNIm7D8ThN6C2WywQKBgQDSqzlsMRjCDGHYAk6I\nF7jqeL134BAxiGKJpp3qjzfdmh9+KvdGIcSGkE0Oc/LXA4A5913TKBEUxC4CfY/e\ntRehwehMag1PyA8+lrvAsBQAR4VCVlN8gYW7FPnSHdmVwNvDdqYR51cHwYtwlA7Z\n/ZAW4hAIzSioOoZ8sN8FUfWHuQKBgQC+VqLaTVI5f+3yZ/Gpr2YGEFm6r1NokKN0\nas41+IbLae118SxMyo4XmpnTv3431kg0fGDepGVoj/EndUb79dclT7FRzgxlSnpp\nsTMoH0BH/hYu7az31F28C2yWBu8BNT0gtLEP3eMtinwIs2yisDjxw+6uAq2bDCeM\n6SAGaJeVMwKBgQDEEY4hDtTPDX0m8IasjP+SYgtc/VG0+A1VtZe1zdOd0KrM3ypC\nwHzLDJRbBjkWOnDmAj71no2/ORLlSH1VNlAnQXR1YiK/hSADDYDyxi3nUKlK41NS\nRq3zP4N/Nj7i7JrcoZnQgfHzCwQ/I91qr16inYV025Sidc3jUS5QIkaVKQKBgBhn\nnVvmPBu5RnYlU7wRDEDMyeSA5G3s1bhwlV4gLpBYVaUgtjBmbE+keALJc9KO/BUW\nuYjyhToh8qa/h8l4nQxgqni1tasrIIT6vndvglt4vbloqhvgs+APiu21l+GMxPiz\nklxZc+576ilncA9wDu0Y1Tqkh0PxDAUqQvvvXzg3AoGAJpSfanPn3YyQ4wbH/vkq\nnZJt7bDcoRNo1WP9/srNXiI8HCHEKtsZpY/lMJFQQpNmbD8CMMa2BX2OfS5jTGGs\nQK5/lI0HVg+Cv92KshxiM/A8tgekaHijoSvdgyYwWknhnK8JLAaVuenUNvplgQpr\n4abIZr7+crCnz4R8hEy067o=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-tvftp@cityeye-7c456.iam.gserviceaccount.com",
      "client_id": "103880502965635080902",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-tvftp%40cityeye-7c456.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    List<String> scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );
    client.close();
    return credentials.accessToken.data;
  }

  static Future subscribeToGroup(String requestId, String userId) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic('topic$requestId');
      print("Subscribed to topic: $requestId");
    } catch (e) {
      print("Error subscribing to topic: $e");
    }
    // Save subscription info to Firestore
    // FirebaseFirestore.instance.collection('subscriptions').doc(requestId).set({
    //   'userId': userId,
    //   'requestId': requestId,
    //   'timestamp': FieldValue.serverTimestamp(),
    // });
  }
}
