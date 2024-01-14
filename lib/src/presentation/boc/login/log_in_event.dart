import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent {}

class LoginApiEvent extends LoginEvent {
  final String email;
  final String password;

  LoginApiEvent({required this.email, required this.password});
}

class NavigateToForgetPasswordEvent extends LoginEvent {}

class ValidateEmailEvent extends LoginEvent {
  final String email;

  ValidateEmailEvent({required this.email});
}

class ValidatePasswordEvent extends LoginEvent {
  final String password;
  ValidatePasswordEvent({
    required this.password,
  });
}

class ValidateEmailAndPasswordEvent extends LoginEvent {
  final String email;
  final String password;

  ValidateEmailAndPasswordEvent({required this.email, required this.password});
}

class LoginPopEvent extends LoginEvent {}

class LogInApiEvent extends LoginEvent {
  final String email;
  final String password;

  LogInApiEvent({
    required this.email,
    required this.password,
  });
}
