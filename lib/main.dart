import 'package:flutter/material.dart';
import 'homepage.dart';
import 'jogo.dart';


void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        Jogo.routeName:(context) => Jogo(),
      },
    );
  }
}
