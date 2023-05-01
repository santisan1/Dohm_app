import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _isvisible = false;
  SplashScreenState() {
    Timer(const Duration(milliseconds: 5000), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      });
    });
    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isvisible = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: AnimatedOpacity(
          opacity: _isvisible ? 1.0 : 0,
          duration: const Duration(milliseconds: 1200),
          child: const Center(
            child: ClipOval(
                child: Image(
              image: AssetImage("assets/logo.jpg"),
            )),
          ),
        ));
  }
}
