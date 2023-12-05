import 'package:flutter_advanced_topics/src/di/bloc_injector.dart';
import 'package:flutter_advanced_topics/src/di/data_layer_injector.dart';
import 'package:flutter_advanced_topics/src/di/repository_injector.dart';
import 'package:flutter_advanced_topics/src/di/use_case_injector.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  await initializeDataDependencies();
  await initializeRepositoryDependencies();
  await initializeUseCaseDependencies();
  await initializeBlocDependencies();
}
