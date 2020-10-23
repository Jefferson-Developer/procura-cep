import 'package:atividade8/enderecos.dart';
import 'package:atividade8/enderecos_api.dart';
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
        title: Text("${cidade}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future:
              EnderecosApi.allEnderecos(cidade: cidade, logadouro: rua, uf: uf),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container(
                width: 200.0,
                height: 200.0,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 5.0,
                ),
              );
              //_buildListViewPosts(snapshot.data);
            } else
              return _buildListViewEnderecos(snapshot.data);
          },
        ),
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

  GestureDetector _listTileEnderecos(List<Enderecos> enderecos, int i) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
          title: Text(
            "Cep: " + enderecos[i].cep,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Logadouro: " + enderecos[i].logradouro,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )),
    );
  }
}
