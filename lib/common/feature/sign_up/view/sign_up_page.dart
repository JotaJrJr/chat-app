import 'package:chat_app/common/database/auth/auth_service.dart';
import 'package:chat_app/common/feature/home/view/home_page.dart';
import 'package:chat_app/common/feature/login/view/login_page.dart';
import 'package:chat_app/common/feature/login/widgets/passoword_text_field_widget.dart';
import 'package:chat_app/common/feature/sign_up/viewmodel/sign_up_view_model.dart';
import 'package:chat_app/common/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SignUpViewModel(authService: Provider.of<AuthService>(context, listen: false));
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
            Align(
              alignment: Alignment.center,
              child: const Icon(
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
            const SizedBox(height: 12.0),
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
            const SizedBox(height: 12.0),
            const Text("Confirmar Senha"),
            const SizedBox(height: 8.0),
            AnimatedBuilder(
                animation: _viewModel,
                builder: (_, __) {
                  return PasswordTextFieldWidget(
                    onPressed: _viewModel.obscurePassword,
                    controller: _viewModel.confirmPasswordController,
                    obscureText: _viewModel.obscureText,
                  );
                }),
            const SizedBox(height: 22.0),
            GestureDetector(
              onTap: () {
                if (_viewModel.canCreateAccount()) {
                  try {
                    _viewModel.createAccount().then((_) {
                      navigateToPage(const HomePage());
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Erro ao criar conta"),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Preencha os campos corretamente"),
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.blue,
                    )),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login),
                    SizedBox(width: 8.0),
                    Text(
                      "Cadastrar",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Já possui uma conta?"),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage())),
                  child: const Text(
                    "Entrar",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void navigateToPage(Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }
}
