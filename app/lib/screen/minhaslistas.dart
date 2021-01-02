import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listadecompras/components/formproduto_component.dart';
import 'package:listadecompras/screen/listadeprodutos.dart';

class MinhasListas extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: Icon(Icons.shopping_basket),
        title: Text(
          "Minhas Listas de Compras",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraint) => ListView(
          children: [
            sizedBoxWidget(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Informe um produto",
                      suffix: FlatButton(
                        child: Text("Adicionar"),
                        onPressed: () {
                          //criar produto
                        },
                      )),
                ),
                height: 70),
            sizedBoxWidget(
                height: constraint.maxHeight, child: ListaDeProdutos())
          ],
        ),
      ),
    );
  }

  Widget sizedBoxWidget({Widget child, double height}) {
    return SizedBox(
      height: height,
      child: child,
    );
  }
}
