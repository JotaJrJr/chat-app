import 'package:chat_app/common/database/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService authService;

  LoginViewModel({required this.authService});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  void obscurePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  bool canLogin() {
    return emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  Future<void> login() async {
    await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
  }
}
