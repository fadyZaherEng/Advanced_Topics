// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_state.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/utils/login_controller.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/utils/login_error_massage.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/widgets/already_have_account_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/widgets/divider_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/widgets/forget_password_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/widgets/log_in_title_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/widgets/login_alternative_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/widgets/valid_password_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_button_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_text_form_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/password_text_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/terms_and_condition_text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInContentWidget extends StatefulWidget {
  LoginController loginController;
  LoginErrorMassage loginErrorMassage;
  void Function(String) validateEmailAddress;
  void Function(String) validatePassword;
  void Function() onLogInPressed;
  void Function() onForgetPasswordPressed;
  void Function() onSignUpPressed;
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasNumber;
  final bool hasSpecialCharacters;
  final bool hasMinLength;
  final bool allValid;
  final bool emptyPassword;

  LogInContentWidget(
      {super.key,
      required this.loginController,
      required this.loginErrorMassage,
      required this.validateEmailAddress,
      required this.validatePassword,
      required this.onLogInPressed,
      required this.onForgetPasswordPressed,
      required this.onSignUpPressed,
      required this.hasLowerCase,
      required this.hasUpperCase,
      required this.hasNumber,
      required this.hasSpecialCharacters,
      required this.hasMinLength,
      required this.allValid,
      required this.emptyPassword});

  @override
  State<LogInContentWidget> createState() => _LogInContentWidgetState();
}

class _LogInContentWidgetState extends State<LogInContentWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInBloc, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoginTitleWidget(),
                    CustomTextFieldWidget(
                      controller: widget.loginController.emailController,
                      errorMessage: widget.loginErrorMassage.email,
                      labelTitle: "Email",
                      onChange: widget.validateEmailAddress,
                    ),
                    SizedBox(height: 20.h),
                    PasswordTextFieldWidget(
                      controller: widget.loginController.passwordController,
                      labelTitle: "Password",
                      onChange: widget.validatePassword,
                      errorMessage: widget.loginErrorMassage.password,
                    ),
                    SizedBox(height: 5.h),
                    if (!widget.allValid)
                      PasswordValidations(
                        hasLowerCase: widget.hasLowerCase,
                        hasUpperCase: widget.hasUpperCase,
                        hasSpecialCharacters: widget.hasSpecialCharacters,
                        hasNumber: widget.hasNumber,
                        hasMinLength: widget.hasMinLength,
                        hasEmpty: widget.emptyPassword,
                      ),
                    SizedBox(height: 20.h),
                    ForgetPasswordWidget(
                      onForgetPasswordPressed: widget.onForgetPasswordPressed,
                    ),
                    SizedBox(height: 30.h),
                    CustomButtonWidget(
                      onPressed: widget.onLogInPressed,
                      title: "Log In",
                      padding: 5,
                    ),
                    SizedBox(height: 30.h),
                    const DividerWidget(),
                    SizedBox(height: 30.h),
                    const LoginAlternativeWidget(),
                    SizedBox(height: 35.h),
                    const TermsAndConditionsTextWidget(),
                    SizedBox(height: 10.h),
                    Center(
                      child: AlreadyHaveAccountTextWidget(
                        onSignUpPressed: widget.onSignUpPressed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
