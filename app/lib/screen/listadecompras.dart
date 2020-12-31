import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listadecompras/components/listaprodutos_components.dart';

class ListaDeCompras extends StatefulWidget {
  createState() => ListaDeComprasState();
}

class ListaDeComprasState extends State<ListaDeCompras> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [ListaDeProdutos()],
      ),
    );
  }
}
