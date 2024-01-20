import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/doc_app.dart';
import 'package:flutter_advanced_topics/src/core/utils/bloc_observer.dart';
import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/restart_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service/local_notification.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service/notification_services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = const SimpleBlocObserver();
  // await NotificationService().initializeNotificationService();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // await initializeDependencies();
  // //fcm rest api and local notification and call firebase massaging using api
  // await LocalNotificationService.initialize();
  // await LocalNotificationService.callFirebaseMassaging();
  // //another way to show local notification
  // await NotificationService().initializeNotificationService();

  runApp(const RestartWidget(DocApp()));
}
