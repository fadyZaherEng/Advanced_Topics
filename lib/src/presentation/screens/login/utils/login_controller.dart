import 'package:flutter/cupertino.dart';

class LoginController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginController({
    required this.emailController,
    required this.passwordController,
  });
}
