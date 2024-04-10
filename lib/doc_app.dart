// ignore_for_file: depend_on_referenced_packages

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/flavors.dart';
import 'package:flutter_advanced_topics/generated/l10n.dart';
import 'package:flutter_advanced_topics/src/config/route/routes_manager.dart';
import 'package:flutter_advanced_topics/src/config/theme/app_theme.dart';
import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/advanced_way_to_fix_internet/network_connectivity.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/new_media/add_payment/add_payment_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/otp_all_way/otp_with_timer/otp_bloc/otp_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/otp_all_way/otp_with_timer/otp_screen.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/qr_props/badge_identity/badge_identity_bloc/badge_identity_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocApp extends StatefulWidget {
  const DocApp({super.key});

  @override
  State<DocApp> createState() => _DocAppState();
}

class _DocAppState extends State<DocApp> {
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  bool isOnline = true;

  @override
  void initState() {
    _internetConnectionListener();
    super.initState();
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => injector<LogInBloc>()),
        BlocProvider(create: (context) => injector<AddPaymentBloc>()),
        BlocProvider(create: (context) => injector<BadgeIdentityBloc>()),
        BlocProvider(create: (context) => injector<OtpBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: F.title,
          debugShowCheckedModeBanner: false,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          onGenerateRoute: RouteGenerator.getRoute,
          //initialRoute: AppRoutes.splashScreen,
          theme: AppTheme("en").light,
          locale: const Locale('en'),
          home: const OTPScreen(userId: 1, phoneNumber: "1234567890"),
        ),
      ),
    );
  }

  void _internetConnectionListener() {
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) async {
      _source = source;
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          isOnline = _source.values.toList()[0];
          break;
        case ConnectivityResult.wifi:
          isOnline = _source.values.toList()[0];
          break;
        case ConnectivityResult.none:
        default:
          isOnline = false;
      }
      if (!mounted && navigatorKey.currentState != null) {
        _networkConnectivity.showOrHideNoInternetDialog(
            isOnline, navigatorKey.currentState!.context);
      }
    });
  }
}
