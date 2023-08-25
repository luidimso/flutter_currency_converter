import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

 Uri url = Uri.https('api.hgbrasil.com', '/finance', {'key': '06a34179'});

double dollar = 0;
double euro = 0;

final realController = TextEditingController();
final dollarController = TextEditingController();
final euroController = TextEditingController();

void _clearAll(){
  realController.text = "";
  dollarController.text = "";
  euroController.text = "";
}

void realChanged(String value) {
  if(value.isEmpty) {
    _clearAll();
    return;
  }

  double real = double.parse(value);
  dollarController.text = (real/dollar).toStringAsFixed(2);
  euroController.text = (real/euro).toStringAsFixed(2);
}

void dollarChanged(String value) {
  if(value.isEmpty) {
    _clearAll();
    return;
  }

  double dollarInput = double.parse(value);
  realController.text = (dollarInput * dollar).toStringAsFixed(2);
  euroController.text = (dollarInput * dollar / euro).toStringAsFixed(2);
}

void euroChanged(String value) {
  if(value.isEmpty) {
    _clearAll();
    return;
  }

  double euroInput = double.parse(value);
  realController.text = (euroInput * euro).toStringAsFixed(2);
  dollarController.text = (euroInput * euro / dollar).toStringAsFixed(2);
}

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

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      buildTextField("Real", "BRL", realController),
                      const Divider(),
                      buildTextField("Dollar", "USD", dollarController),
                      const Divider(),
                      buildTextField("Euro", "EUR", euroController)
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

Widget buildTextField(String label, String prefix, TextEditingController controller) {
  callEvent(String value) {
    switch (label) {
      case "Real":
        realChanged(value);
      case "Dollar":
        dollarChanged(value);
      case "Euro":
        euroChanged(value);
    }
  }


  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.amber
        ),
        prefixText: prefix
    ),
    style: const TextStyle(
        color: Colors.white,
        fontSize: 25
    ),
    onChanged: callEvent,
  );
}
