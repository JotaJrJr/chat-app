import 'package:chat_app/common/services/auth/auth_gate.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () => _navigateToHomePage());
    super.initState();
  }

  Future<void> _navigateToHomePage() {
    // return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthGateWidget()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Splash Screen',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Text("Aplicativo de Chat, doideira"),
          ),
        ],
      ),
    );
  }
}
