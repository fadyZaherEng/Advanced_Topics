import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/firebase_options.dart';
import 'package:flutter_advanced_topics/flavors.dart';
import 'package:flutter_advanced_topics/generated/l10n.dart';
import 'package:flutter_advanced_topics/src/config/route/routes_manager.dart';
import 'package:flutter_advanced_topics/src/core/utils/bloc_observer.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_no_internet_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/restart_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service/new_with_hms/firebase_notification_services.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service/new_with_hms/hms_notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class NetworkConnectivity {
  NetworkConnectivity._();

  static final _instance = NetworkConnectivity._();

  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();

  Stream get myStream => _controller.stream;

  void initializeInternetConnectivityStream() {
    _networkConnectivity.onConnectivityChanged.listen((result) {
      return _controller.sink.add(result);
    });
  }

  Future<bool> isInternetConnected() async {
    final result = await InternetAddress.lookup('www.google.com');
    bool isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    return isOnline;
  }

  bool isShowNoInternetDialog = false;

  void disposeStream() => _controller.close();
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  if (!kIsWeb) {
    try {
      if (Platform.isIOS) {
        await _initializeFirebaseServices();
      } else {
        final int resultCode =
        await HmsApiAvailability().isHMSAvailableWithApkVersion(28);
        if (resultCode == 1) {
          await _initializeFirebaseServices();
        } else {
          await _initializeHuaweiServices();
        }
      }
    } catch (e) {}
  }
  runApp(
    const RestartWidget(MyApp()),
  );

  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const RestartWidget(MyApp()), // Wrap your app
  //   ),
  // );
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      NetworkConnectivity.instance.initializeInternetConnectivityStream();
    }
  }

  @override
  Widget build(BuildContext context) {
    return    StreamBuilder(
        stream: NetworkConnectivity.instance.myStream,
        builder: (mContext, snapshot) {
          if (snapshot.hasData && !kIsWeb) {
            ConnectivityResult connectivityResult = snapshot.data;
            if (connectivityResult == ConnectivityResult.none) {
              if (!NetworkConnectivity.instance.isShowNoInternetDialog) {
                showNoInternetDialogWidget(
                    context: navigatorKey.currentContext ?? context,
                    onTapTryAgain: () {});
              }
              NetworkConnectivity.instance.isShowNoInternetDialog = true;
            } else {
              if (NetworkConnectivity.instance.isShowNoInternetDialog &&
                  Navigator.canPop(
                      navigatorKey.currentContext ?? context)) {
                Navigator.of(navigatorKey.currentContext ?? context)
                    .pop();
                NetworkConnectivity.instance.isShowNoInternetDialog =
                false;
              }
            }
          }
          return Portal(
            child: Provider.value(
              value: routeObserver,
              child:  MaterialApp(
                // useInheritedMediaQuery: true,
                // builder: DevicePreview.appBuilder,
                // darkTheme:AppTheme(state.languageCode).light,
                navigatorKey: navigatorKey,
                navigatorObservers: [
                  ChuckerFlutter.navigatorObserver,
                  routeObserver,
                ],
                themeMode: ThemeMode.light,
                supportedLocales: S.delegate.supportedLocales,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                onGenerateRoute: RouteGenerator.getRoute,
                initialRoute: AppRoutes.splashScreen,
                debugShowCheckedModeBanner: false,
                title: F.title,
                // theme: AppTheme(state.languageCode).light,
                // locale: state,
              ),
            ),
          );
        });
  }
}

Future<void> _initializeFirebaseServices() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseNotificationService().initializeNotificationService();
    Bloc.observer = const SimpleBlocObserver();
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } catch (e) {}
}

Future<void> _initializeHuaweiServices() async {
  await HMSNotificationServices().initializeNotificationService();
}
