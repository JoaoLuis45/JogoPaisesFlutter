import 'package:flutter/material.dart';
import 'jogo.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'cert.dart';
import 'package:http/http.dart' as http;
import 'app_config.dart';
class HomePage2 extends StatefulWidget {
  static bool isLoading = false;
  const HomePage2({super.key});

  static Future<List> paises() async {
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
        var paises = json.decode(utf8.decode(response.bodyBytes));

        for (int i = 0; i <= 272; i++) {
          paisesABV.add(
              (paises[i]['id']['ISO-3166-1-ALPHA-2']).toString().toLowerCase());
          paisesNome.add(paises[i]['nome']['abreviado']);
          paisesAbvNome.addAll({paisesABV[i]: paisesNome[i]});
        }

        List abv = paisesABV;
      } else {
        print('erro');
      }
    });
    return [paisesABV, paisesAbvNome];
  }

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
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
              onPressed: () => Navigator.pushNamed(context, 'config'),
              icon: Icon(Icons.miscellaneous_services)),
          title: Center(
            child: Text(
              'CountryGuess',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
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
                      if (!HomePage2.isLoading) {
                        setState(() {
                          HomePage2.isLoading = true;
                        });
                      }

                      HomePage2.paises().then((value) {
                        Navigator.pushNamed(context, Jogo.routeName,
                            arguments: ScreenArguments(value));
                      });
                    },
                    child: HomePage2.isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
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
