import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/domain/entities/auth/sign_in_response.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginEmailNotValidState extends LoginState {
  final String errorMassage;

  LoginEmailNotValidState({required this.errorMassage});
}

class LoginEmailValidState extends LoginState {}

class LoginPasswordNotValidState extends LoginState {
  final String errorMassage;

  LoginPasswordNotValidState({required this.errorMassage});
}

class LoginPasswordValidState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailApiState extends LoginState {
  final String errorMassage;

  LoginFailApiState({required this.errorMassage});
}

class LoginPopState extends LoginState {}

class LoginNavigateToForgetPasswordState extends LoginState {}

class SignInLoadingState extends LoginState {}

class SignInSuccessState extends LoginState {
  SignIn signIn;
  SignInSuccessState({required this.signIn});
}

class SignInFailApiState extends LoginState {
  final String errorMassage;

  SignInFailApiState({required this.errorMassage});
}
