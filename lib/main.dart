import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

 Uri url = Uri.https('api.hgbrasil.com', '/finance', {'key': '06a34179'});

void main() async {
  http.Response response = await http.get(url);
  print(response.body);

  runApp(MaterialApp(
    home: Container(),
  ));
}