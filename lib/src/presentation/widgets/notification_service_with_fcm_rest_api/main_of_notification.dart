import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/firebase_options.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service/fcm_rest_api.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service_with_fcm_rest_api/notification_service/local_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ;
  await DioHelper.Init();
  await LocalNotificationService.initializeNotificationService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Notification App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            String token = await FirebaseMessaging.instance.getToken() ?? '';
            DioHelper.postData(token: token, massage: "hello").then((value) {
              print(value.data);
            });
          },
          child: const Text("send notification"),
        ),
      ),
    );
  }
}
