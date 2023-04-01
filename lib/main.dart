import 'package:flutter/material.dart';
import 'homepage.dart';
import 'jogo.dart';
import 'resultado.dart';
import 'dart:async';
import 'app_config.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage2(),
        Jogo.routeName: (context) => Jogo(),
        Resultado.routeName: (context) => Resultado(),
        Configs.routeName:(context) => Configs(),
      },
    );
  }
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 3));
}
