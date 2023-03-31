import 'package:flutter/material.dart';
import 'package:httprequest/homepage.dart';
import 'jogo.dart';

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
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Jogo dos Países',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Voce acertou:\n   ${args.acertos} Países!',
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    HomePage2.isLoading = false;
                    Jogo.acertos = 0;
                    Jogo.numeroPergunta = 0;
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text(
                    'Reiniciar',
                    style: TextStyle(fontSize: 50),
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
  ScreenArgumentsResultado(this.acertos);
}
