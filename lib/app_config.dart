import 'dart:io';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:audioplayers/audioplayers.dart';

class Configs extends StatefulWidget {
  static bool light = false;
  static bool music = true;
  static bool soundEffects = true;

  static String routeName = 'config';
  const Configs({super.key});

  @override
  State<Configs> createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ScreenArgumentsConfig;
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
              onPressed: () => Navigator.pushNamed(context, '/'),
              icon: Icon(Icons.arrow_back)),
          title: Center(
            child: Text(
              'CountryGuess',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Tema:',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                      value: Configs.light,
                      onChanged: (bool value) {
                        setState(() {
                          Configs.light = !Configs.light;
                        });
                      }),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Música:',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                      value: Configs.music,
                      onChanged: (bool value) {
                        setState(() {
                          if (args.music != null) {
                            args.music?.stop();
                          }
                          Configs.music = !Configs.music;
                        });
                      }),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Efeitos:',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                      value: Configs.soundEffects,
                      onChanged: (bool value) {
                        setState(() {
                          if (args.soundEffects != null) {
                            args.soundEffects?[0].stop();
                            args.soundEffects?[1].stop();
                          }
                          Configs.soundEffects = !Configs.soundEffects;
                        });
                      }),
                ],
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Text(
                    'Desenvolvido por: João Luís',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenArgumentsConfig {
  final AudioPlayer? music;
  final List<AudioPlayer>? soundEffects;
  ScreenArgumentsConfig({this.music, this.soundEffects});
}
