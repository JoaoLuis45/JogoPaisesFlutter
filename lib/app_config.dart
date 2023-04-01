import 'dart:io';

import 'package:flutter/material.dart';
import 'main.dart';

class Configs extends StatefulWidget {
  static bool light = true;
  static String routeName = 'config';
  const Configs({super.key});

  @override
  State<Configs> createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Configs.light ? Brightness.dark : Brightness.light,
          primarySwatch: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => exit(0), icon: Icon(Icons.exit_to_app_sharp))
          ],
          leading: IconButton(
              onPressed: () => Navigator.pushNamed(context,'/'),
              icon: Icon(Icons.arrow_back)),
          title: Center(
            child: Text(
              'CountryGuess',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Row(
            children: [
              Text('Tema:'),
              Switch(
                  value: Configs.light,
                  onChanged: (bool value) {
                    setState(() {
                      Configs.light = !Configs.light;
                      ;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
