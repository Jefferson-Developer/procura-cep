import 'package:atividade8/pages/enderecos_listview_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class BuscaEnderecos extends StatefulWidget {
  @override
  _BuscaEnderecosState createState() => _BuscaEnderecosState();
}

class _BuscaEnderecosState extends State<BuscaEnderecos> {
  String selecionada = 'PB';
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController cidade = TextEditingController();
  TextEditingController logradouro = TextEditingController();
  String solicitar = "";
  GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();
  Future<Map> obterDados() async {
    http.Response resposta = await http.get(solicitar);
    return json.decode(resposta.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _keyScaffold,
        appBar: AppBar(
          title: Text("Busca Cep"),
        ),
        body: FutureBuilder<Map>(
          future: obterDados(),
          builder: (context, snapshot) {
            return Form(
              key: _keyForm,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  buildDropdownStatic(),
                  TextFormField(
                    controller: cidade,
                    decoration: InputDecoration(
                        labelText: "Cidade",
                        labelStyle: TextStyle(color: Colors.blue)),
                    validator: (valor) {
                      if (valor.isEmpty) {
                        return "Campo Cidade não pode ser vazio.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    validator: (valor) {
                      if (valor.isEmpty) {
                        return "Campo Logradouro não pode ser vazio.";
                      }
                      return null;
                    },
                    controller: logradouro,
                    decoration: InputDecoration(
                      labelText: "Logradouro",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextButton.icon(
                    icon: snapshot.hasData
                        ? Icon(
                            Icons.search,
                            color: Colors.blue,
                          )
                        : Container(
                            width: 20.0,
                            height: 20.0,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                              strokeWidth: 5.0,
                            ),
                          ),
                    label: Text(
                      "Buscar",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      alteracaoEstado();
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }

  alteracaoEstado() {
    setState(() {
      _salvar();
    });
  }

  buildDropdownStatic() {
    return DropdownButton<String>(
      value: selecionada,
      isExpanded: true,
      icon: Icon(Icons.arrow_drop_down),
      underline: Container(
        height: 2,
        color: Colors.black38,
      ),
      items: [
        DropdownMenuItem(
          child: Text("Paraíba"),
          value: 'PB',
        ),
        DropdownMenuItem(
          child: Text("Pernambuco"),
          value: 'PE',
        ),
        DropdownMenuItem(
          child: Text("Bahia"),
          value: 'BA',
        ),
      ],
      onChanged: (valor) {
        receberNovoValor(valor);
      },
    );
  }

  receberNovoValor(String valor) {
    setState(() {
      selecionada = valor;
    });
  }

  _salvar() {
    if (_keyForm.currentState.validate()) {
      _keyForm.currentState.save();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EnderecosListViewPage(
                cidade.text.trim().replaceAll("%", " "),
                logradouro.text.trim().replaceAll("%", " "),
                selecionada)),
      );
    } else {
      _meuSnackBar();
    }
  }

  _meuSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
      action:
          SnackBarAction(textColor: Colors.red, label: "", onPressed: () {}),
      content: Row(
        children: [
          Icon(Icons.error),
          SizedBox(
            width: 30,
          ),
          Text("Dados inválidos !")
        ],
      ),
    ));
  }
}
