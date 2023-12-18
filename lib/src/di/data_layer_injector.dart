import 'package:flutter_advanced_topics/src/core/utils/network/dio_factory.dart';
import 'package:flutter_advanced_topics/src/data/sources/remote/doc_doc/auth/auth_api_service.dart';
import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeDataDependencies() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  injector.registerLazySingleton(
    () => DioFactory.getDio(),
  );
  injector.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );
  injector.registerLazySingleton<AuthApiService>(
    () => AuthApiService(injector()),
  );
}
