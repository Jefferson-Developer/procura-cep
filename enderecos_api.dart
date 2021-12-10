import 'package:atividade8/object/enderecos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converter;

class EnderecosApi {
  static Future<Enderecos> obterEndereco(
      {String uf, String cidade, String logadouro}) async {
    String url = "https://viacep.com.br/ws/$uf/$cidade/$logadouro/json/";

    try {
      http.Response resposta = await http.get(url);
      if (resposta.statusCode == 200) {
        Map<String, dynamic> map = converter.jsonDecode(resposta.body);
        return Enderecos.fromJson(map);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Enderecos>> todosOsEnderecos(
      {String uf, String cidade, String logadouro}) async {
    String url = "https://viacep.com.br/ws/$uf/$cidade/$logadouro/json/";
    List<Enderecos> endereco = [];
    try {
      http.Response resposta = await http.get(url);
      List<dynamic> maps = converter.jsonDecode(resposta.body);
      endereco = maps.map((e) => Enderecos.fromJson(e)).toList();
    } catch (e) {}
    return endereco;
  }
}
