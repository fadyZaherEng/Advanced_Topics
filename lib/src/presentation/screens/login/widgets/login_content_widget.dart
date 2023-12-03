import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/utils/login_controller.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/utils/login_error_massage.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/widgets/already_have_account_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/widgets/forget_password_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/widgets/log_in_title_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_text_form_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/password_text_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/terms_and_condition_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInContentWidget extends StatefulWidget {
  LoginController loginController;
  LoginErrorMassage loginErrorMassage;
  void Function(String) validateEmailAddress;
  void Function(String) validatePassword;
  void Function() onLogInPressed;
  void Function() onForgetPasswordPressed;
  void Function() onSignUpPressed;

  LogInContentWidget({
    super.key,
    required this.loginController,
    required this.loginErrorMassage,
    required this.validateEmailAddress,
    required this.validatePassword,
    required this.onLogInPressed,
    required this.onForgetPasswordPressed,
    required this.onSignUpPressed,
  });

  @override
  State<LogInContentWidget> createState() => _LogInContentWidgetState();
}

class _LogInContentWidgetState extends State<LogInContentWidget> {
  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 20.h,
              ),
              PasswordTextFieldWidget(
                controller: widget.loginController.passwordController,
                labelTitle: "Password",
                onChange: widget.validatePassword,
                errorMessage: widget.loginErrorMassage.password,
              ),
              SizedBox(
                height: 20.h,
              ),
              ForgetPasswordWidget(
                onForgetPasswordPressed: widget.onForgetPasswordPressed,
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomButtonWidget(
                onPressed: widget.onLogInPressed,
                title: "Log In",
                padding: 5,
              ),
              SizedBox(
                height: 20.h,
              ),
              const TermsAndConditionsTextWidget(),
              SizedBox(
                height: 30.h,
              ),
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
  }
}
