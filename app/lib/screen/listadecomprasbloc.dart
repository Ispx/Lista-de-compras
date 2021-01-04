import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listadecompras/bloc/produtos_bloc.dart';
import 'package:listadecompras/components/icon_component.dart';
import 'package:listadecompras/components/sizedbox_component.dart';
import 'package:listadecompras/models/produto.dart';

class ListaDeCOmprasBloc extends StatefulWidget {
  @override
  _ListaDeComprasBlocState createState() => _ListaDeComprasBlocState();
}

class _ListaDeComprasBlocState extends State<ListaDeCOmprasBloc> {
  final _produtosBloc = ProdutosBloc();
  Widget build(BuildContext context) {
    _produtosBloc.ler();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        leading: Icon(Icons.shopping_basket),
        title: Text(
          "Lista de Compras",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.purple[500],
      body: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, infoScreen) => ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child:
                    sizedBoxComponent(child: formularioProduto(), height: 80),
              ),
              StreamBuilder<List<Produto>>(
                stream: _produtosBloc.output,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.active:
                      break;
                    case ConnectionState.done:
                      return sizedBoxComponent(
                          height: infoScreen.maxHeight,
                          child: listaDeProdutos(snapshot));
                      break;
                    default:
                      return Center(
                        child: Text("Nenhum produto encotrado"),
                      );
                  }
                  return sizedBoxComponent(
                      height: infoScreen.maxHeight,
                      child: listaDeProdutos(snapshot));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  formularioProduto() {
    final TextEditingController _controller = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _controller,
        validator: (value) {
          if (value.length == 2 || value.trim().isEmpty) {
            return "Produto inválido";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Informe um produto",
          suffix: FlatButton(
            child: Text("Adicionar"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Produto produto = Produto();
                produto.setNome(_controller.text.toString());
                _produtosBloc.inserir(produto);
                _formKey.currentState.reset();
              }
            },
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.purple[400]),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.purple[700]),
          ),
        ),
      ),
    );
  }

  listaDeProdutos(AsyncSnapshot<List<Produto>> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Produto produto = snapshot.data[index];
        return Dismissible(
          key: ValueKey(produto),
          background: iconComponent(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              icon: Icons.delete,
              padding: EdgeInsets.only(left: 20)),
          secondaryBackground: iconComponent(
              color: Colors.green,
              alignment: Alignment.centerRight,
              icon: Icons.check,
              padding: EdgeInsets.only(right: 20)),
          onDismissed: (direction) {
            return DismissDirection.startToEnd;
          },
          confirmDismiss: (direction) async {
            if (DismissDirection.startToEnd == direction) {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Deletar item: " +
                        produto.nome.toString().toUpperCase()),
                    actions: [
                      FlatButton(
                        child: Text("Sim"),
                        onPressed: () {
                          _produtosBloc.deletar(produto);
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text("Não"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              );
            }
            return false;
          },
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 1))),
            child: ListTile(
              leading: iconComponent(
                  icon: Icons.shopping_basket_sharp,
                  color: Colors.orange,
                  function: null),
              title: Text(
                produto.nome.toString().toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: LayoutBuilder(
                builder: (context, constraint) => Container(
                  width: constraint.maxWidth / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      iconComponent(
                        icon: Icons.add,
                        color: Colors.black,
                        function: () => _produtosBloc.increment(produto),
                      ),
                      _quantidadeDeProdutos(produto),
                      iconComponent(
                        icon: Icons.remove,
                        color: Colors.black,
                        function: () => _produtosBloc.decrement(produto),
                      ),
                    ],
                  ),
                ),
              ),
              onLongPress: () => _produtosBloc.deletar(produto),
            ),
          ),
        );
      },
    );
  }

  Widget _quantidadeDeProdutos(Produto produto) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: Colors.black),
        //color: Colors.black,
      ),
      child: Align(
        child: Text(
          "" + produto.quantidade.toString(),
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ),
    );
  }
}
