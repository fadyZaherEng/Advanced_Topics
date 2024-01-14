import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/show_massage_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_event.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_state.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/utils/login_controller.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/utils/login_error_massage.dart';
import 'package:flutter_advanced_topics/src/presentation/screens/login/widgets/login_content_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends BaseStatefulWidget {
  const LogInScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _LogInScreenState();
}

class _LogInScreenState extends BaseState<LogInScreen> {
  LogInBloc get _bloc => BlocProvider.of<LogInBloc>(context);
  final LoginController _loginController = LoginController(
    emailController: TextEditingController(),
    passwordController: TextEditingController(),
  );
  final LoginErrorMassage _loginErrorMassage = LoginErrorMassage();
  bool _hasLowerCase = false;
  bool _hasUpperCase = false;
  bool _hasNumber = false;
  bool _hasSpecialCharacters = false;
  bool _hasMinLength = false;
  bool _allValid = false;
  bool _emptyPassword = false;
  @override
  initState() {
    super.initState();
    _loginController.passwordController.addListener(() {
      _validatePassword(_loginController.passwordController.text);
    });
  }

  @override
  void dispose() {
    _loginController.emailController.dispose();
    _loginController.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<LogInBloc, LoginState>(
      listener: (bloc, state) {
        print(state);
        if (state is LoginEmailNotValidState) {
          _loginErrorMassage.email = state.errorMassage;
        } else if (state is LoginEmailValidState) {
          _loginErrorMassage.email = null;
        } else if (state is LoginPasswordValidState) {
          _loginErrorMassage.password = null;
          _allValid = true;
        } else if (state is LoginPopState) {
          _pop();
        } else if (state is LoginNavigateToForgetPasswordState) {
          _navigateToForgotPasswordScreen();
        } else if (state is SignInFailApiState) {
          hideLoading();
          _showMassageDialog(state.errorMassage);
        } else if (state is SignInLoadingState) {
          showLoading();
        } else if (state is SignInSuccessState) {
          print(state.signIn.token);
          hideLoading();
          _navigateToHomeScreen();
        } else if (state is LoginPasswordEmptyState) {
          _emptyPassword = true;
          _loginErrorMassage.password = ""; //state.errorMassage;
        } else if (state is LoginPasswordHasLowerCaseState) {
          _hasLowerCase = true;
          _loginErrorMassage.password = "";
        } else if (state is LoginPasswordHasUpperCaseState) {
          _hasUpperCase = true;
          _loginErrorMassage.password = "";
        } else if (state is LoginPasswordHasNumberState) {
          _hasNumber = true;
          _loginErrorMassage.password = "";
        } else if (state is LoginPasswordHasSpecialCharactersState) {
          _hasSpecialCharacters = true;
          _loginErrorMassage.password = "";
        } else if (state is LoginPasswordHasMinLengthState) {
          _hasMinLength = true;
          _loginErrorMassage.password = "";
        } else if (state is LoginPasswordNotEmptyState) {
          _emptyPassword = false;
          _allValid = false;
          _loginErrorMassage.password = " "; //state.errorMassage;
        } else if (state is LoginPasswordNotHasLowerCaseState) {
          _hasLowerCase = false;
          _allValid = false;
          _loginErrorMassage.password = " ";
        } else if (state is LoginPasswordNotHasUpperCaseState) {
          _hasUpperCase = false;
          _allValid = false;
          _loginErrorMassage.password = " ";
        } else if (state is LoginPasswordNotHasNumberState) {
          _hasNumber = false;
          _allValid = false;
          _loginErrorMassage.password = " ";
        } else if (state is LoginPasswordNotHasSpecialCharactersState) {
          _hasSpecialCharacters = false;
          _allValid = false;
          _loginErrorMassage.password = " ";
        } else if (state is LoginPasswordNotHasMinLengthState) {
          _hasMinLength = false;
          _allValid = false;
          _loginErrorMassage.password = " ";
        }
      },
      builder: (bloc, state) {
        return Scaffold(
          body: LogInContentWidget(
            loginController: _loginController,
            loginErrorMassage: _loginErrorMassage,
            validateEmailAddress: (email) {
              _validateEmailAddress(email);
            },
            validatePassword: (password) {
              _validatePassword(password);
            },
            onForgetPasswordPressed: _navigateToForgotPasswordScreen,
            onLogInPressed: () {
              _bloc.add(
                LogInApiEvent(
                  email: _loginController.emailController.text,
                  password: _loginController.passwordController.text,
                ),
              );
            },
            onSignUpPressed: () {
              _navigateToLogUpScreen();
            },
            hasLowerCase: _hasLowerCase,
            hasUpperCase: _hasUpperCase,
            hasNumber: _hasNumber,
            hasSpecialCharacters: _hasSpecialCharacters,
            hasMinLength: _hasMinLength,
            allValid: _allValid,
            emptyPassword: _emptyPassword,
          ),
        );
      },
    );
  }

  void _validatePassword(String password) {
    _bloc.add(ValidatePasswordEvent(
      password: password,
    ));
  }

  void _validateEmailAddress(String email) {
    _bloc.add(ValidateEmailEvent(email: email));
  }

  void _navigateToForgotPasswordScreen() {
    Navigator.of(context).pushNamed('/forgetPassword');
  }

  void _navigateToHomeScreen() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _pop() {
    Navigator.of(context).pop();
  }

  void _navigateToLogUpScreen() {
    Navigator.of(context).pushNamed('/logUpScreen');
  }

  void _showMassageDialog(String errorMassage) {
    showMassageDialogWidget(
      context: context,
      text: errorMassage,
      icon: 'assets/images/onboarding_doc.png',
      buttonText: 'Ok',
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
