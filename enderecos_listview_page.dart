import 'package:atividade8/object/enderecos.dart';
import 'package:atividade8/api/enderecos_api.dart';
import 'package:flutter/material.dart';

class EnderecosListViewPage extends StatelessWidget {
  String cidade;
  String rua;
  String uf;

  EnderecosListViewPage(String cidade, String rua, String uf) {
    this.cidade = cidade;
    this.rua = rua;
    this.uf = uf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$cidade"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
            future: EnderecosApi.todosOsEnderecos(
                cidade: cidade, logadouro: rua, uf: uf),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        strokeWidth: 5.0,
                      ),
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao Carregar Dados :(",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    return _buildListViewEnderecos(snapshot.data);
                  }
              }
            }),
      ),
    );
  }

  ListView _buildListViewEnderecos(List<Enderecos> enderecos) {
    return ListView.builder(
      itemCount: enderecos.length,
      itemBuilder: (BuildContext context, int i) {
        return _listTileEnderecos(enderecos, i);
      },
    );
  }

  GestureDetector _listTileEnderecos(List<Enderecos> enderecos, int iterator) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
          title: Text(
            "Cep: " + enderecos[iterator].cep,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Logadouro: " + enderecos[iterator].logradouro,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )),
    );
  }
}
