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
      )
    );
  }
}
