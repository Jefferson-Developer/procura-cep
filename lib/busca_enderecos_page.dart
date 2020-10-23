import 'package:atividade8/enderecos_listview_page.dart';
import 'package:flutter/material.dart';

class BuscaEnderecosPage extends StatefulWidget {
  @override
  _BuscaEnderecosPageState createState() => _BuscaEnderecosPageState();
}

class _BuscaEnderecosPageState extends State<BuscaEnderecosPage> {
  String selecionada = 'PB';
  TextEditingController cidadeController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Busca Cep"),
        ),
        body: Container(
          //padding: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              buildDropdownEstatico(),
              TextField(
                controller: cidadeController,
                decoration: InputDecoration(
                  labelText: "Cidade",
                ),
              ),
              TextField(
                controller: logradouroController,
                decoration: InputDecoration(
                  labelText: "Logradouro",
                ),
              ),
              RaisedButton(
                child: Text("Buscar"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EnderecosListViewPage(
                            cidadeController.text,
                            logradouroController.text,
                            selecionada)),
                  );
                },
              )
            ],
          ),
        ));
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
