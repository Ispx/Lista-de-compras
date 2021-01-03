import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:listadecompras/models/produtos_factory.dart';
import 'package:listadecompras/screen/minhaslistas.dart';
import 'database/database.dart';
import 'models/produto.dart';

void main() async {
  runApp(MyApp());
  ProdutoFactory().ler().then((produtos) {
    produtos.forEach((produto) {
      print(produto.getMap());
    });
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MinhasListas(),
    );
  }
}
