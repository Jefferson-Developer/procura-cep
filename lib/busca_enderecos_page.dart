import 'package:atividade8/enderecos_listview_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class BuscaEnderecosPage extends StatefulWidget {
  @override
  _BuscaEnderecosPageState createState() => _BuscaEnderecosPageState();
}

class _BuscaEnderecosPageState extends State<BuscaEnderecosPage> {
  String selecionada = 'PB';
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  String request = "";

  Future<Map> getData() async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Busca Cep"),
        ),
        body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            return Form(
              key: _keyForm,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  buildDropdownEstatico(),
                  TextFormField(
                    controller: cidadeController,
                    decoration: InputDecoration(
                        labelText: "Cidade",
                        labelStyle: TextStyle(color: Colors.blue)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Campo nome não pode ser vazio.";
                      }
                      return null;
                    },
                    //onSaved: (value) {},
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Campo nome não pode ser vazio.";
                      }
                      return null;
                    },
                    controller: logradouroController,
                    decoration: InputDecoration(
                      labelText: "Logradouro",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  RaisedButton.icon(
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
                      _salvar();
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }

  _salvar() {
    if (_keyForm.currentState.validate()) {
      _keyForm.currentState.save();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EnderecosListViewPage(
                cidadeController.text.trim().replaceAll("%", " "),
                logradouroController.text.trim().replaceAll("%", " "),
                selecionada)),
      );
    }
  }

  buildDropdownEstatico() {
    return DropdownButton<String>(
      value: selecionada,
      //dropdownColor: Colors.grey,
      isExpanded: true,
      icon: Icon(Icons.add),
      underline: Container(
        height: 2,
        color: Colors.black38,
      ),
      items: [
        DropdownMenuItem(
          child: Text("Paraiba"),
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
      onChanged: (value) {
        print(value);
        setState(() {
          selecionada = value;
        });
      },
    );
  }
}
