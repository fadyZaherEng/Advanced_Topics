import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_advanced_topics/src/core/resource/data_state.dart';
import 'package:flutter_advanced_topics/src/core/utils/network/api_error_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/validation/login_validation.dart';
import 'package:flutter_advanced_topics/src/data/sources/remote/doc_doc/auth/sign_in/request/sign_in_request.dart';
import 'package:flutter_advanced_topics/src/domain/entities/auth/sign_in_response.dart';
import 'package:flutter_advanced_topics/src/domain/use_case/authentication/login/email_validation_use_case.dart';
import 'package:flutter_advanced_topics/src/domain/use_case/authentication/login/password_validation_use_case.dart';
import 'package:flutter_advanced_topics/src/domain/use_case/authentication/login/sign_in_use_case.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_event.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_state.dart';

class LogInBloc extends Bloc<LoginEvent, LoginState> {
  final EmailValidationUseCase _emailValidationUseCase;
  final PasswordValidationUseCase _passwordValidationUseCase;
  final SignInUseCase _signInUseCase;

  LogInBloc(
    this._emailValidationUseCase,
    this._passwordValidationUseCase,
    this._signInUseCase,
  ) : super(LoginInitial()) {
    on<ValidateEmailEvent>(_onValidateEmailEvent);
    on<ValidatePasswordEvent>(_onValidatePasswordEvent);
    on<LoginPopEvent>(_onLoginPopEvent);
    on<NavigateToForgetPasswordEvent>(_onNavigateToForgetPasswordEvent);
    on<LogInApiEvent>(_onLogInEvent);
  }

  void _onValidateEmailEvent(
      ValidateEmailEvent event, Emitter<LoginState> emit) {
    ValidationState validationState = _emailValidationUseCase(event.email);

    if (validationState == ValidationState.emailEmpty) {
      emit(LoginEmailNotValidState(errorMassage: "Email Address Is Required"));
    } else if (validationState == ValidationState.emailNotValid) {
      emit(LoginEmailNotValidState(
          errorMassage: "please Enter Valid Email Address "));
    } else {
      emit(LoginEmailValidState());
    }
  }

  void _onValidatePasswordEvent(
      ValidatePasswordEvent event, Emitter<LoginState> emit) {
    List<ValidationState> validationStatePassword = _passwordValidationUseCase(
      password: event.password,
    );
    if (validationStatePassword.contains(ValidationState.passwordEmpty)) {
      emit(LoginPasswordNotValidState(errorMassage: "Password Is Required"));
    }
    if (validationStatePassword.contains(ValidationState.passwordNotValid)) {
      emit(LoginPasswordNotValidState(errorMassage: "Password Is Not Valid"));
    }
    if (validationStatePassword
        .contains(ValidationState.passwordHasMinLength)) {
      emit(LoginPasswordHasMinLengthState());
    }
    if (validationStatePassword.contains(ValidationState.passwordHasNumber)) {
      emit(LoginPasswordHasNumberState());
    }
    if (validationStatePassword
        .contains(ValidationState.passwordHasUppercase)) {
      emit(LoginPasswordHasUpperCaseState());
    }
    if (validationStatePassword
        .contains(ValidationState.passwordHasLowercase)) {
      emit(LoginPasswordHasLowerCaseState());
    }
    if (validationStatePassword
        .contains(ValidationState.passwordHasSpecialCharacters)) {
      emit(LoginPasswordHasSpecialCharactersState());
    } else {
      emit(LoginPasswordValidState());
    }
  }

  void _onLoginPopEvent(LoginPopEvent event, Emitter<LoginState> emit) {
    emit(LoginPopState());
  }

  void _onNavigateToForgetPasswordEvent(
      NavigateToForgetPasswordEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToForgetPasswordState());
  }

  FutureOr<void> _onLogInEvent(
      LogInApiEvent event, Emitter<LoginState> emit) async {
    ValidationState validationStateEmail = _emailValidationUseCase(event.email);
    List<ValidationState> validationStatePassword = _passwordValidationUseCase(
      password: event.password,
    );
    if (validationStateEmail == ValidationState.emailEmpty) {
      emit(LoginEmailNotValidState(errorMassage: "Email Address Is Required"));
    }
    if (validationStatePassword.contains(ValidationState.passwordEmpty)) {
      emit(LoginPasswordNotValidState(errorMassage: "Password Is Required"));
    }
    if (validationStatePassword.contains(ValidationState.passwordNotValid)) {
      emit(LoginPasswordNotValidState(errorMassage: "Password Is Not Valid"));
    }
    if (validationStatePassword
        .contains(ValidationState.passwordHasMinLength)) {
      emit(LoginPasswordHasMinLengthState());
    }
    if (validationStatePassword.contains(ValidationState.passwordHasNumber)) {
      emit(LoginPasswordHasNumberState());
    }
    if (validationStatePassword
        .contains(ValidationState.passwordHasUppercase)) {
      emit(LoginPasswordHasUpperCaseState());
    }
    if (validationStatePassword
        .contains(ValidationState.passwordHasLowercase)) {
      emit(LoginPasswordHasLowerCaseState());
    }
    if (validationStatePassword
        .contains(ValidationState.passwordHasSpecialCharacters)) {
      emit(LoginPasswordHasSpecialCharactersState());
    }
    if (validationStateEmail == ValidationState.emailNotValid) {
      emit(LoginEmailNotValidState(
          errorMassage: "please Enter Valid Email Address "));
    }
    if (validationStateEmail != ValidationState.emailNotValid &&
        validationStateEmail != ValidationState.emailEmpty &&
        validationStatePassword.contains(ValidationState.passwordValid)) {
      {
        emit(SignInLoadingState());
        final response = await _signInUseCase(
          signInRequest: SignInRequest(
            email: event.email,
            password: event.password,
          ),
        );
        if (response is DataSuccess<SignIn>) {
          emit(SignInSuccessState(
              signIn: response.data ?? const SignIn(token: "", username: "")));
        } else if (response is DataFailed) {
          emit(
            SignInFailApiState(
                errorMassage: ErrorHandler.handle(response.error)
                        .apiErrorModel
                        .error!
                        .response!
                        .statusMessage ??
                    ""),
          );
        }
      }
    }
  }
}
