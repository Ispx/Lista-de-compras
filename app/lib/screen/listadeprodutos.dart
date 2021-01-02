import 'package:flutter/material.dart';
import 'package:listadecompras/bloc/produtos_bloc.dart';
import 'package:listadecompras/components/icon_component.dart';
import 'package:listadecompras/components/quantidade_component.dart';
import 'package:listadecompras/models/produto.dart';

class ListaDeProdutos extends StatefulWidget {
  ListaDeProdutosState createState() => ListaDeProdutosState();
}

class ListaDeProdutosState extends State<ListaDeProdutos> {
  final blocProdutos = ProdutosBloc();
  @override
  Widget build(BuildContext buildContext) {
    blocProdutos.getProdutos();
    return StreamBuilder<List<Produto>>(
      stream: blocProdutos.output,
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
    );
  }

  listBuilderProdutos(AsyncSnapshot<List<Produto>> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Produto produto = snapshot.data[index];
        return ListTile(
          leading:
              iconComponent(icon: Icons.shopping_basket_sharp, function: null),
          title: Text(produto.nome.toString().toUpperCase()),
          trailing: LayoutBuilder(
            builder: (context, constraint) => Container(
              width: constraint.maxWidth / 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconComponent(
                      icon: Icons.add,
                      function: () => blocProdutos.increment(produto)),
                  quantidadeComponent(produto),
                  iconComponent(
                    icon: Icons.remove,
                    function: () => blocProdutos.decrement(produto),
                  ),
                ],
              ),
            ),
          ),
          onLongPress: () => blocProdutos.remove(produto),
        );
      },
    );
  }
}
