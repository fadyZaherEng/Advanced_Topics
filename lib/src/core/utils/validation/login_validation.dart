class LoginValidation {
  static bool isEmailValid(String email) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    var regExp = RegExp(pattern);

    return regExp.hasMatch(email.trim());
  }

  static List<ValidationState> isPasswordValid({
    required String password,
  }) {
    List<ValidationState> validationStates = [];
    if (password.isNotEmpty) {
      validationStates.add(ValidationState.passwordEmpty);
      if (validationStates.contains(ValidationState.passwordNotEmpty)) {
        validationStates.remove(ValidationState.passwordNotEmpty);
      }
    } else {
      if (validationStates.contains(ValidationState.passwordEmpty)) {
        validationStates.remove(ValidationState.passwordEmpty);
      }
      validationStates.add(ValidationState.passwordNotEmpty);
    }
    if (password.toString().length > 6) {
      validationStates.add(ValidationState.passwordHasMinLength);
      if (validationStates.contains(ValidationState.passwordNotHasMinLength)) {
        validationStates.remove(ValidationState.passwordNotHasMinLength);
      }
    } else {
      if (validationStates.contains(ValidationState.passwordHasMinLength)) {
        validationStates.remove(ValidationState.passwordHasMinLength);
      }
      validationStates.add(ValidationState.passwordNotHasMinLength);
    }
    if (password.toString().contains(RegExp(r'[a-z]'))) {
      validationStates.add(ValidationState.passwordHasLowercase);
      if (validationStates.contains(ValidationState.passwordNotHasLowercase)) {
        validationStates.remove(ValidationState.passwordNotHasLowercase);
      }
    } else {
      if (validationStates.contains(ValidationState.passwordHasLowercase)) {
        validationStates.remove(ValidationState.passwordHasLowercase);
      }
      validationStates.add(ValidationState.passwordNotHasLowercase);
    }
    if (password.toString().contains(RegExp(r'[A-Z]'))) {
      validationStates.add(ValidationState.passwordHasUppercase);
      if (validationStates.contains(ValidationState.passwordNotHasUppercase)) {
        validationStates.remove(ValidationState.passwordNotHasUppercase);
      }
    } else {
      if (validationStates.contains(ValidationState.passwordHasUppercase)) {
        validationStates.remove(ValidationState.passwordHasUppercase);
      }
      validationStates.add(ValidationState.passwordNotHasUppercase);
    }
    if (password.toString().contains(RegExp(r'[0-9]'))) {
      validationStates.add(ValidationState.passwordHasNumber);
      if (validationStates.contains(ValidationState.passwordNotHasNumber)) {
        validationStates.remove(ValidationState.passwordNotHasNumber);
      }
    } else {
      if (validationStates.contains(ValidationState.passwordHasNumber)) {
        validationStates.remove(ValidationState.passwordHasNumber);
      }
      validationStates.add(ValidationState.passwordNotHasNumber);
    }
    if (password.toString().contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      validationStates.add(ValidationState.passwordHasSpecialCharacters);
      if (validationStates
          .contains(ValidationState.passwordNotHasSpecialCharacters)) {
        validationStates
            .remove(ValidationState.passwordNotHasSpecialCharacters);
      }
    } else {
      if (validationStates
          .contains(ValidationState.passwordHasSpecialCharacters)) {
        validationStates.remove(ValidationState.passwordHasSpecialCharacters);
      }
      validationStates.add(ValidationState.passwordNotHasSpecialCharacters);
    }
    if (password.isNotEmpty &&
        password.toString().length > 6 &&
        password.toString().contains(RegExp(r'[a-z]')) &&
        password.toString().contains(RegExp(r'[A-Z]')) &&
        password.toString().contains(RegExp(r'[0-9]')) &&
        password.toString().contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      validationStates.clear();
      validationStates.add(ValidationState.passwordValid);
    }
    return validationStates;
  }

  static ValidationState validateEmail(String email) {
    if (email.isEmpty) {
      return ValidationState.emailEmpty;
    } else if (!isEmailValid(email)) {
      return ValidationState.emailNotValid;
    } else {
      return ValidationState.emailValid;
    }
  }

  static List<ValidationState> validatePassword({
    required String password,
  }) {
    return isPasswordValid(password: password);
  }
}

enum ValidationState {
  passwordEmpty,
  passwordNotValid,
  passwordValid,
  emailEmpty,
  emailNotValid,
  emailValid,
  passwordHasUppercase,
  passwordHasLowercase,
  passwordHasNumber,
  passwordHasSpecialCharacters,
  passwordHasMinLength,
  passwordNotHasUppercase,
  passwordNotHasLowercase,
  passwordNotHasNumber,
  passwordNotHasSpecialCharacters,
  passwordNotHasMinLength,
  passwordNotEmpty,
}
