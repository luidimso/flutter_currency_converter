import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

 Uri url = Uri.https('api.hgbrasil.com', '/finance', {'key': '06a34179'});

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme:  ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map> get() async {
  Uri url = Uri.https('api.hgbrasil.com', '/finance', {'key': '06a34179'});
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dollar = 0;
  double euro = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Converter"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: get(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text("Loading...",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25.0
                ),),
              );
            default:
              if(snapshot.hasError) {
                return const Center(
                  child: Text("Error :(",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0
                    ),),
                );
              } else {
                dollar = snapshot.data?["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data?["results"]["currencies"]["EUR"]["buy"];

                print(dollar);
                print(euro);

                return const SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Reais",
                          labelStyle: TextStyle(
                            color: Colors.amber
                          ),
                          prefixText: "BRL"
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                        ),
                      ),
                      Divider(),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Dollars",
                            labelStyle: TextStyle(
                                color: Colors.amber
                            ),
                            prefixText: "USD"
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25
                        ),
                      ),
                      Divider(),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Euros",
                            labelStyle: TextStyle(
                                color: Colors.amber
                            ),
                            prefixText: "EUR"
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25
                        ),
                      )
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}


/* theme: ThemeData(
hintColor: Colors.amber,
primaryColor: Colors.white,
inputDecorationTheme: InputDecorationTheme(
enabledBorder:
OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
focusedBorder:
OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
hintStyle: TextStyle(color: Colors.amber),
)),
)); */
