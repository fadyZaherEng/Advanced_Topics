import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_bloc.dart';

Future<void> initializeBlocDependencies() async {
  injector.registerFactory<LogInBloc>(
      () => LogInBloc(injector(), injector(), injector()));
}
