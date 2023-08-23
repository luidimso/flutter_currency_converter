import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

 Uri url = Uri.https('api.hgbrasil.com', '/finance', {'key': '06a34179'});

void main() async {
  runApp(MaterialApp(
    home: Home(),
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
                return Container(
                  color: Colors.green,
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
