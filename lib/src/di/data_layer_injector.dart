import 'package:dio/dio.dart';
import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> initializeDataDependencies() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  injector.registerLazySingleton(() => Dio()
    ..options.baseUrl = ِAPIKeys.baseUrl
    ..interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    )));
  injector.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

}
