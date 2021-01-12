import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:listadecompras/app/components/icon_component.dart';
import 'package:listadecompras/app/components/sizedbox_component.dart';
import 'package:listadecompras/app/models/produto.dart';
import 'package:listadecompras/app/viewmodels/nicknamepreferences_viewmodel.dart';

import 'listadecompras_controller.dart';

class ListaDeComprasPage extends StatefulWidget {
  @override
  _ListaDeComprasPageState createState() => _ListaDeComprasPageState();
}

class _ListaDeComprasPageState extends State<ListaDeComprasPage> {
  bool _panelExpanded = false;
  final _listaDeComprasController = Modular.get<ListaDeComprasController>();
  final _sharedNickName = Modular.get<NickNamePreferencesViewModel>();

  Widget build(BuildContext context) {
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
      body: Container(
        margin: const EdgeInsets.only(top: 40, right: 2, left: 2, bottom: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: LayoutBuilder(
          builder: (context, infoScreen) => ListView(
            children: [
              sizedBoxComponent(
                height: infoScreen.maxHeight,
                child: Observer(
                  builder: (context) => FutureBuilder<List<Produto>>(
                    initialData: [Produto()],
                    future: _listaDeComprasController.listaDeProdutos,
                    builder: (context, produtos) {
                      if (produtos.hasError || produtos.data.length == 0) {
                        return Center(
                          child: Text("Nenhum produto identificado"),
                        );
                      }
                      return _expansionPanelListProdutos(
                          context, produtos, infoScreen);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.purple[900],
        height: 60,
        buttonBackgroundColor: Colors.purple[900],
        backgroundColor: Colors.purple[500],
        items: [
          Icon(
            Icons.shopping_cart_sharp,
            color: Colors.white,
            size: 45,
          ),
        ],
        onTap: (value) {
          Navigator.pushNamed(context, '/novalista');
        },
      ),
    );
  }

  _expansionPanelListProdutos(BuildContext context,
      AsyncSnapshot<List<Produto>> produtos, BoxConstraints infoScreen) {
    return SingleChildScrollView(
      child: Observer(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionPanelList(
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
                      "Lista de Compras",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  );
                },
                body: sizedBoxComponent(
                  height: infoScreen.maxHeight / 2,
                  child: Container(
                    width: infoScreen.maxWidth,
                    height: infoScreen.maxHeight / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: produtos.data.length,
                      itemBuilder: (context, index) {
                        Produto produto = produtos.data[index];
                        return ListTile(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  iconComponent(
                                    icon: Icons.add,
                                    color: Colors.black,
                                    function: () => _listaDeComprasController
                                        .increment(produto),
                                  ),
                                  _quantidadeDeProdutos(produto),
                                  iconComponent(
                                    icon: Icons.remove,
                                    color: Colors.black,
                                    function: () => _listaDeComprasController
                                        .decrement(produto),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
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
