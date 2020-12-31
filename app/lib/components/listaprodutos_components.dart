import 'package:flutter/material.dart';
import 'package:listadecompras/bloc/listaprodutos_bloc.dart';
import 'package:listadecompras/models/produto.dart';

class ListaDeProdutos extends StatefulWidget {
  final bloc = ListaDeProdutosBloc();
  ListaDeProdutosState createState() => ListaDeProdutosState();
}

class ListaDeProdutosState extends State<ListaDeProdutos> {
  @override
  Widget build(BuildContext buildContext) {
    widget.bloc.getProdutos();
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height / 3,
      child: StreamBuilder<List<Produto>>(
        stream: widget.bloc.output,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return listBuilderProdutos(snapshot);
              break;
            default:
              return Center(
                child: Text("Nenhum produto encotnrado"),
              );
          }
          return listBuilderProdutos(snapshot);
        },
      ),
    );
  }

  listBuilderProdutos(AsyncSnapshot<List<Produto>> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Produto produto = snapshot.data[index];
        return ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text(produto.nome),
          trailing: LayoutBuilder(
            builder: (context, constraint) => Container(
              width: constraint.maxWidth / 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.add,
                    size: 20,
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Align(
                        child: Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )),
                  ),
                  Icon(
                    Icons.remove,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
