import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/theme_helper/theme_helper.dart';
import 'package:flutter_application_1/screens/registration_screen.dart';
import 'package:flutter_application_1/screens/home/main_screen.dart';
import 'package:flutter_application_1/screens/widgets/HeaderWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final double _headerHeight = 250;
  final Key _formkey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  chequoInicio() async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection('Users');
      QuerySnapshot user = await ref.get();
      if (user.docs.isNotEmpty) {
        for (var cursor in user.docs) {
          if (cursor.get("Email") == userName.text) {
            print('Email encontrado');
            if (cursor.get("Contraseña") == password.text) {
              print('inicio de sesión exitoso');
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            } else {
              print('na');
            }
          }
        }
      } else {
        print('No hay ningún usuario');
      }
    } catch (e) {
      print('erro $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login),
            ),
            SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30.0),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextField(
                            controller: userName,
                            decoration: ThemeHelper().textInputDecoration(
                                'Username', 'Ingrese su usuario'),
                          ),
                          const SizedBox(height: 30.0),
                          TextField(
                            controller: password,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                              'Contraseña',
                              'Ingrese su contraseña',
                            ),
                          ),
                          const SizedBox(height: 35.0),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                            alignment: Alignment.topRight,
                            child: const Text('Olvidé mi contraseña'),
                          ),
                          Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  'Inciar Sesión'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                print('Enviando');
                                chequoInicio();
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                            // child: const Text('Crear cuenta')
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                      text: '¿Todavía no tienes cuenta?'),
                                  TextSpan(
                                    text: ' Creala aquí',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegistrationPage(),
                                          ),
                                        );
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
