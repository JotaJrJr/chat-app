import 'package:chat_app/common/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthService authService;

  SignUpViewModel({required this.authService});

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  bool obscureText = true;

  void obscurePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  bool canCreateAccount() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  Future<UserCredential> createAccount() async {
    return await authService.signUpWithEmailAndPassword(emailController.text, passwordController.text);
  }
}
