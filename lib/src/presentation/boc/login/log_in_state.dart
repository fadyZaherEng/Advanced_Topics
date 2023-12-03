import 'package:flutter/material.dart';

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
