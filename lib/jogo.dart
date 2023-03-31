import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class Jogo extends StatefulWidget {
  static String pais = 'ad';
  static String img = 'https://flagcdn.com/256x192/$pais.png';
  static int numeroPergunta = 1;
  static List alternativas = ['Andorra', 'Mexico', 'Egito', 'Russia'];
  static String acertouErrou = '';
  static List numsEmbaralahados = [0, 1, 2, 3];
  static const routeName = 'jogo';
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    List sorteiaNum() {
      List nums = [0, 1, 2, 3];
      nums.shuffle();

      return nums;
    }

    void proximaPergunta() {
      Jogo.numsEmbaralahados = sorteiaNum();
      Jogo.acertouErrou = '';
      setState(() {
        var rng = Random();
        Jogo.pais = args.lista[0][rng.nextInt(272)];
        var paisCerto = args.lista[1][Jogo.pais];
        List paisesErrados = [];
        for (int i = 0; i < 3; i++) {
          var paisErrado = args.lista[0][rng.nextInt(272)];
          paisErrado = args.lista[1][paisErrado];
          paisesErrados.add(paisErrado);
        }
        Jogo.alternativas = [];
        paisesErrados.forEach((element) {
          Jogo.alternativas.add(element);
        });
        Jogo.alternativas.add(paisCerto);
        print(Jogo.alternativas);
        Jogo.img = 'https://flagcdn.com/256x192/${Jogo.pais}.png';
        Jogo.numeroPergunta += 1;
      });
    }

    bool verificaResposta(String paisCerto, String resposta) {
      bool verificacao = false;
      var paisCorreto = args.lista[1][paisCerto];
      if (paisCorreto == resposta) {
        verificacao = true;
        setState(() {
          Jogo.acertouErrou = 'Acertou!';
        });
      } else {
        setState(() {
          Jogo.acertouErrou = 'Errou!';
        });
      }

      return verificacao;
    }

    Future<void> espera() async {
      return Future.delayed(Duration(seconds: 2), () => proximaPergunta());
    }

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Pergunta ${Jogo.numeroPergunta}',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Image.network(Jogo.img),
                Text(
                  '${Jogo.acertouErrou}',
                  style: TextStyle(fontSize: 50),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      verificaResposta(Jogo.pais,
                          Jogo.alternativas[Jogo.numsEmbaralahados[0]]);

                      espera();
                    },
                    child: Text(
                      '${Jogo.alternativas[Jogo.numsEmbaralahados[0]]}',
                      style: TextStyle(fontSize: 40),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      verificaResposta(Jogo.pais,
                          Jogo.alternativas[Jogo.numsEmbaralahados[1]]);

                      espera();
                    },
                    child: Text(
                      '${Jogo.alternativas[Jogo.numsEmbaralahados[1]]}',
                      style: TextStyle(fontSize: 40),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      verificaResposta(Jogo.pais,
                          Jogo.alternativas[Jogo.numsEmbaralahados[2]]);

                      espera();
                    },
                    child: Text(
                      '${Jogo.alternativas[Jogo.numsEmbaralahados[2]]}',
                      style: TextStyle(fontSize: 40),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      verificaResposta(Jogo.pais,
                          Jogo.alternativas[Jogo.numsEmbaralahados[3]]);

                      espera();
                    },
                    child: Text(
                      '${Jogo.alternativas[Jogo.numsEmbaralahados[3]]}',
                      style: TextStyle(fontSize: 40),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScreenArguments {
  final List lista;
  ScreenArguments(this.lista);
}

MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
  final getColor = (Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return colorPressed;
    } else {
      return color;
    }
  };

  return MaterialStateProperty.resolveWith(getColor);
}
