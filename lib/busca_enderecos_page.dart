import 'package:atividade8/enderecos_listview_page.dart';
import 'package:flutter/material.dart';

class BuscaEnderecosPage extends StatefulWidget {
  @override
  _BuscaEnderecosPageState createState() => _BuscaEnderecosPageState();
}

class _BuscaEnderecosPageState extends State<BuscaEnderecosPage> {
  String selecionada = 'PB';
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Busca Cep"),
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            buildDropdownEstatico(),
            TextFormField(
              controller: cidadeController,
              decoration: InputDecoration(
                labelText: "Cidade",
              ),
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
              ),
            ),
            RaisedButton(
              child: Text("Buscar"),
              onPressed: () {
                _salvar();
              },
            ),
          ],
        ),
      ),
    );
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
