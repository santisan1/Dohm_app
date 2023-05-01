import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color _primaryColor = Color.fromARGB(255, 89, 45, 192);
  final Color _accentColor = const Color(0xFF8A02AE);

  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: _primaryColor,
          accentColor: _accentColor,
          scaffoldBackgroundColor: Colors.grey.shade100,
          primarySwatch: Colors.purple),
      title: 'Dohm_test',
      home: const SplashScreen(),
    );
  }
}
