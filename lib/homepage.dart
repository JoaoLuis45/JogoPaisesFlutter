import 'package:flutter/material.dart';
import 'jogo.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'cert.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<List> paises() async {
    //certificado
    HttpOverrides.global = MyHttpOverrides();

    final url =
        Uri.https('servicodados.ibge.gov.br', '/api/v1/paises/{paises}');
    final future = http.get(url);
    List paisesABV = [];
    List paisesNome = [];
    Map paisesAbvNome = {};
    await future.then((response) {
      if (response.statusCode == 200) {
        var paises = json.decode(response.body);

        for (int i = 0; i <= 272; i++) {
          paisesABV.add(
              (paises[i]['id']['ISO-3166-1-ALPHA-2']).toString().toLowerCase());
          var paisesNomeUtf8encode =
              utf8.encode(paises[i]['nome']['abreviado']);
          var paisesNomeUtf8Decode = utf8.decode(paisesNomeUtf8encode);
          paisesNome.add(paisesNomeUtf8Decode);
          paisesAbvNome.addAll({paisesABV[i]: paisesNome[i]});
        }
        print(paisesAbvNome);
        List abv = paisesABV;
      } else {
        print('erro');
      }
    });
    return [paisesABV, paisesAbvNome];
  }

  @override
  Widget build(BuildContext context) {
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
                Image.asset('assets/images/paises.png'),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      paises().then((value) {
                        Navigator.pushNamed(context, 'jogo',
                            arguments: ScreenArguments(value));
                      });
                    },
                    child: Text(
                      'Jogar',
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
      ),
    );
  }
}
