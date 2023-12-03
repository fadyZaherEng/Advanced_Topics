import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/domain/use_case/authentication/login/email_validation_use_case.dart';
import 'package:flutter_advanced_topics/src/domain/use_case/authentication/login/password_validation_use_case.dart';

Future<void> initializeUseCaseDependencies() async {
  injector
      .registerFactory<EmailValidationUseCase>(() => EmailValidationUseCase());
  injector.registerFactory<PasswordValidationUseCase>(
      () => PasswordValidationUseCase());
}
