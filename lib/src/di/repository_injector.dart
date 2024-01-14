import 'package:flutter_advanced_topics/src/data/repositories/auth_repository_implementation.dart';
import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/domain/repositories/auth_repository.dart';

Future<void> initializeRepositoryDependencies() async {
  injector.registerFactory<AuthRepository>(
    () => AuthRepositoryImplementation(injector()),
  );
}
