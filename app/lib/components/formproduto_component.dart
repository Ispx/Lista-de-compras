import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listadecompras/bloc/produtos_bloc.dart';
import 'package:listadecompras/models/produto.dart';
import 'package:listadecompras/models/produtos_factory.dart';

class FormProduto extends StatefulWidget {
  ProdutosBloc _produtoBloc;
  FormProduto();
  @override
  FormProdutoState createState() {
    return FormProdutoState();
  }
}

class FormProdutoState extends State<FormProduto> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
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
              print("salvou");
              if (_formKey.currentState.validate()) {
                print("salvou");
                Produto produto = Produto(null, _controller.text, 1);
                ProdutoFactory().salvar(produto);
              }
            },
          ),
        ),
      ),
    );
  }
}
