import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listadecompras/bloc/produtos_bloc.dart';
import 'package:listadecompras/components/icon_component.dart';
import 'package:listadecompras/components/quantidade_component.dart';
import 'package:listadecompras/models/produto.dart';

class MinhasListas extends StatefulWidget {
  @override
  _MinhasListasState createState() => _MinhasListasState();
}

class _MinhasListasState extends State<MinhasListas> {
  final _produtosBloc = ProdutosBloc();
  Widget build(BuildContext context) {
    _produtosBloc.getProdutos();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        leading: Icon(Icons.shopping_basket),
        title: Text(
          "Minhas Listas de Compras",
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
          builder: (context, constraint) => ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: sizedBoxWidget(child: formulario(), height: 80),
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
                        return sizedBoxWidget(
                            height: constraint.maxHeight,
                            child: listBuilderProdutos(snapshot));
                        break;
                      default:
                        return Center(
                          child: Text("Nenhum produto encotnrado"),
                        );
                    }

                    return sizedBoxWidget(
                        height: constraint.maxHeight,
                        child: listBuilderProdutos(snapshot));
                  })
            ],
          ),
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

  formulario() {
    final TextEditingController _controller = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _controller,
        validator: (value) {
          if (value.length == 2 || value.trim().isEmpty) {
            return "Texto inválido";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Informe um produto",
          suffix: FlatButton(
            child: Text("Adicionar"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Produto produto = Produto(null, _controller.text, 1);
                _produtosBloc.adicionaProduto(produto);
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

  listBuilderProdutos(AsyncSnapshot<List<Produto>> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Produto produto = snapshot.data[index];
        return Dismissible(
          key: ValueKey(produto),
          background: dimissibleIcon(
              background: Colors.red,
              alignment: Alignment.centerLeft,
              icon: Icons.delete,
              padding: EdgeInsets.only(left: 20)),
          secondaryBackground: dimissibleIcon(
              background: Colors.green,
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
                          _produtosBloc.remove(produto);
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
                      quantidadeComponent(produto),
                      iconComponent(
                        icon: Icons.remove,
                        color: Colors.black,
                        function: () => _produtosBloc.decrement(produto),
                      ),
                    ],
                  ),
                ),
              ),
              onLongPress: () => _produtosBloc.remove(produto),
            ),
          ),
        );
      },
    );
  }

  Container dimissibleIcon(
      {Color background,
      Alignment alignment,
      IconData icon,
      EdgeInsets padding}) {
    return Container(
      color: background,
      padding: padding,
      child: Align(
        alignment: alignment,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
