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
    if (password.isEmpty) {
      validationStates.add(ValidationState.passwordEmpty);
      return validationStates;
    }
    if (password.toString().length > 6) {
      validationStates.add(ValidationState.passwordHasMinLength);
    }
    if (password.toString().contains(RegExp(r'[a-z]'))) {
      validationStates.add(ValidationState.passwordHasLowercase);
    }
    if (password.toString().contains(RegExp(r'[A-Z]'))) {
      validationStates.add(ValidationState.passwordHasUppercase);
    }
    if (password.toString().contains(RegExp(r'[0-9]'))) {
      validationStates.add(ValidationState.passwordHasNumber);
    }
    if (password.toString().contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      validationStates.add(ValidationState.passwordHasSpecialCharacters);
    } else if ((validationStates
            .contains(ValidationState.passwordHasMinLength) ||
        validationStates.contains(ValidationState.passwordHasNumber) ||
        validationStates.contains(ValidationState.passwordHasUppercase) ||
        validationStates.contains(ValidationState.passwordHasLowercase) ||
        validationStates
                .contains(ValidationState.passwordHasSpecialCharacters) &&
            !validationStates.contains(ValidationState.passwordEmpty))) {
    } else {
      validationStates.add(ValidationState.passwordNotValid);
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
}
