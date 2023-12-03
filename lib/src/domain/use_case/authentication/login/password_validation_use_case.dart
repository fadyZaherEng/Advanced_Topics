import 'package:flutter_advanced_topics/src/core/utils/validation/login_validation.dart';

class PasswordValidationUseCase {
  ValidationState call(String password) {
    return LoginValidation.validatePassword(password);
  }
}
