import 'package:flutter_advanced_topics/src/core/utils/validation/login_validation.dart';

class PasswordValidationUseCase {
  List<ValidationState> call({
    required String password,
  }) {
    return LoginValidation.validatePassword(password: password);
  }
}
