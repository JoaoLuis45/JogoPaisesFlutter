import 'dart:io';

import 'package:flutter/material.dart';
import 'package:httprequest/app_config.dart';
import 'package:httprequest/homepage.dart';
import 'jogo.dart';
import 'package:audioplayers/audioplayers.dart';

class Resultado extends StatefulWidget {
  static const routeName = 'resultado';
  const Resultado({super.key});

  @override
  State<Resultado> createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ScreenArgumentsResultado;
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
              onPressed: () => Navigator.pushNamed(context, 'config',
                  arguments: ScreenArgumentsConfig(music: args.music,soundEffects: args.soundEffects)),
              icon: Icon(Icons.miscellaneous_services)),
          title: Center(
            child: Text(
              'CountryGuess',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Voce acertou:\n${args.acertos} Países!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    args.music.stop();
                    HomePage2.isLoading = false;
                    Jogo.acertos = 0;
                    Jogo.numeroPergunta = 1;
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text(
                    'Reiniciar',
                    style: TextStyle(fontSize: 35),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenArgumentsResultado {
  final int acertos;
  final AudioPlayer music;
  final List<AudioPlayer> soundEffects;
  ScreenArgumentsResultado(this.acertos, this.music,this.soundEffects);
}
