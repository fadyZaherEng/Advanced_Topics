import 'package:bloc/bloc.dart';
import 'package:flutter_advanced_topics/src/core/utils/validation/login_validation.dart';
import 'package:flutter_advanced_topics/src/domain/use_case/authentication/login/email_validation_use_case.dart';
import 'package:flutter_advanced_topics/src/domain/use_case/authentication/login/password_validation_use_case.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_event.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_state.dart';

class LogInBloc extends Bloc<LoginEvent, LoginState> {
  final EmailValidationUseCase _emailValidationUseCase;
  final PasswordValidationUseCase _passwordValidationUseCase;

  LogInBloc(
    this._emailValidationUseCase,
    this._passwordValidationUseCase,
  ) : super(LoginInitial()) {
    on<ValidateEmailEvent>(_onValidateEmailEvent);
    on<ValidatePasswordEvent>(_onValidatePasswordEvent);
    on<LoginPopEvent>(_onLoginPopEvent);
    on<NavigateToForgetPasswordEvent>(_onNavigateToForgetPasswordEvent);
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
    ValidationState validationState =
        _passwordValidationUseCase(event.password);
    if (validationState == ValidationState.passwordEmpty) {
      emit(LoginPasswordNotValidState(errorMassage: "Password Is Required"));
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
  //start login implementation

}
