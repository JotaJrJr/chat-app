import 'package:chat_app/common/database/auth/auth_service.dart';
import 'package:chat_app/common/feature/login/viewmodel/login_view_model.dart';
import 'package:chat_app/common/feature/login/widgets/passoword_text_field_widget.dart';
import 'package:chat_app/common/feature/sign_up/view/sign_up_page.dart';
import 'package:chat_app/common/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = LoginViewModel(
      authService: Provider.of<AuthService>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.abc,
                size: 140,
              ),
            ),
            const SizedBox(height: 3.0),
            const Text("Email"),
            const SizedBox(height: 8.0),
            TextFormFieldWidget(
              controller: _viewModel.emailController,
            ),
            const SizedBox(height: 8.0),
            const Text("Senha"),
            const SizedBox(height: 8.0),
            AnimatedBuilder(
                animation: _viewModel,
                builder: (_, __) {
                  return PasswordTextFieldWidget(
                    onPressed: _viewModel.obscurePassword,
                    controller: _viewModel.passwordController,
                    obscureText: _viewModel.obscureText,
                  );
                }),
            const SizedBox(height: 8.0),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.login)),
                TextButton(
                  // onPressed: () => navigateToPage(HomePage()),
                  onPressed: () {
                    if (_viewModel.canLogin()) {
                      try {
                        _viewModel.login();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Email e/ou senha inválidos"),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Email e/ou senha inválidos"),
                        ),
                      );
                    }
                  },
                  child: const Text("Entrar"),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text("Esqueci minha senha"),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Não tem conta?"),
                TextButton(
                  onPressed: () => navigateToPage(const SignUpPage()),
                  child: const Text("Cadastre-se"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void navigateToPage(Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }
}
