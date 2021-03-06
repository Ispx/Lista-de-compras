import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:listadecompras/app/components/icon_component.dart';
import 'package:listadecompras/app/components/sizedbox_component.dart';
import 'package:listadecompras/app/models/lista.dart';
import 'package:listadecompras/app/models/produto.dart';
import 'package:listadecompras/app/services/sqflite/factorys/listadecompras_factory.dart';
import 'package:listadecompras/app/services/sqflite/factorys/produtos_factory.dart';
import 'package:listadecompras/app/viewmodels/nicknamepreferences_viewmodel.dart';
import 'listadecompras_controller.dart';
import 'listadeprodutos_controller.dart';

class ListaDeComprasPage extends StatefulWidget {
  @override
  _ListaDeComprasPageState createState() => _ListaDeComprasPageState();
}

class _ListaDeComprasPageState extends State<ListaDeComprasPage> {
  bool _panelExpanded = false;
  final _listaDeComprasController = Modular.get<ListaDeProdutosController>();
  final _sharedNickName = Modular.get<NickNamePreferencesViewModel>();
  final _novaListaDeComprasController = Modular.get<ListaDeComprasController>();
  ListaDeComprasFactory _listasDeCompras = ListaDeComprasFactory();
  final _inputTextControllerCompras = TextEditingController();

  final _formKey = GlobalKey<FormFieldState>();
  ListaDeProdutosController _produtoFactory = ListaDeProdutosController();
  Widget build(BuildContext context) {
    _produtoFactory.produtosId(2).then((value) {
      value.where((element) => element.fklista == 2).forEach((element) {
        print("Nome do produto: " + element.toString());
      });
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        leading: Icon(Icons.shopping_basket),
        title: FutureBuilder<String>(
          future: _sharedNickName.getNickName(),
          builder: (context, nickname) {
            if (nickname.hasError || !nickname.hasData) {
              return Text(
                "Lista de Compras App",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              );
            }
            return Text(
              "Bem vindo ${nickname.data}",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            );
          },
        ),
      ),
      backgroundColor: Colors.purple[500],
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40, right: 2, left: 2, bottom: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _listasDeCompras.ler(),
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
                    List<Map<String, dynamic>> listasDeCompras = snapshot.data;
                    List<ExpansionPanel> expansionPanelCompras =
                        List<ExpansionPanel>();
                    for (Map listaMap in listasDeCompras) {
                      expansionPanelCompras.add(
                        ExpansionPanel(
                          isExpanded: true,
                          headerBuilder: (context, isExpanded) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listaMap['nome'],
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          },
                          body: FutureBuilder<Iterable<Produto>>(
                            future: _produtoFactory
                                .produtosId(listaMap['lista_id']),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData || snapshot.hasError) {
                                return Center(
                                  child: Text("Nenhum produto encontrado"),
                                );
                              }
                              return Container(
                                height: 200,
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    List<Produto> produtosId =
                                        snapshot.data.toList();
                                    Produto produto = produtosId[index];
                                    return ListTile(
                                      title: Text(produto.nome),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return ExpansionPanelList(
                        expansionCallback: (panelIndex, isExpanded) {
                          setState(
                            () {
                              _panelExpanded = !isExpanded;
                            },
                          );
                        },
                        children: expansionPanelCompras);
                    break;
                  default:
                    return Center(
                      child: Text(
                          "Não foi possível recuperar a lista de produtos"),
                    );
                }
                return ExpansionPanelList(
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(
                      () {
                        _panelExpanded = !isExpanded;
                      },
                    );
                  },
                  children: [
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: _panelExpanded,
                      backgroundColor: Colors.purple[500],
                      headerBuilder: (context, isExpanded) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'dsazz',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        );
                      },
                      body: FutureBuilder<Iterable<Produto>>(
                        future: _produtoFactory.produtosId(2),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.hasError) {
                            return Center(
                              child: Text("Nenhum produto encontrado"),
                            );
                          }
                          return Container(
                            height: 200,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                List<Produto> produtosId =
                                    snapshot.data.toList();
                                Produto produto = produtosId[index];
                                return ListTile(
                                  title: Text(produto.nome),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.purple[900],
        height: 60,
        buttonBackgroundColor: Colors.purple[900],
        backgroundColor: Colors.purple[500],
        items: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_cart_sharp,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
        onTap: (value) {
          if (value == 0) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Nova Lista de compras'),
                  content: TextFormField(
                    key: _formKey,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Inválido";
                      }
                      return null;
                    },
                    controller: _inputTextControllerCompras,
                    maxLength: 44,
                    decoration: InputDecoration(
                      hintText: 'Nome da lista',
                    ),
                  ),
                  actions: [
                    FlatButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text('Confirmar'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Lista lista = Lista();
                          lista.setNome(_inputTextControllerCompras.text);
                          int idLista = await _novaListaDeComprasController
                              .adicionar(lista.toMap());
                          Modular.to.pushNamed('/novalista/${lista.nome}',
                              arguments: idLista);
                        }
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
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
