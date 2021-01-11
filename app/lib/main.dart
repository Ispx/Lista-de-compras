import 'package:flutter/material.dart';
import 'package:listadecompras/app/pages/home/listadecompras_page.dart';

void main() async {
  runApp(MyApp());
  // deleteDatabaseApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaDeComprasPage(),
    );
  }
}
