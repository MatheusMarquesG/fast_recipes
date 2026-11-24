import 'dart:convert';

import 'package:fast_recipes/modelos/receita.dart';
import 'package:http/http.dart' as http;

class ErroApi implements Exception {
  final String mensagem;

  ErroApi(this.mensagem);
}

class ServicoReceitas {
  static const String _url = 'https://dummyjson.com/recipes';

  static Future<List<Receita>> buscarTodas() {
    return _buscar(Uri.parse('$_url?limit=0'));
  }

  static Future<List<Receita>> pesquisar(String termo) {
    return _buscar(Uri.parse('$_url/search?limit=0&q=${Uri.encodeQueryComponent(termo)}'));
  }

  static Future<List<Receita>> _buscar(Uri url) async {
    http.Response resposta;
    try {
      resposta = await http.get(url);
    } catch (e) {
      throw ErroApi('Sem conexão com a internet. Verifique sua rede e tente novamente.');
    }

    if (resposta.statusCode != 200) {
      throw ErroApi('O servidor respondeu com erro (código ${resposta.statusCode}). Tente novamente.');
    }

    try {
      Map<String, dynamic> json = jsonDecode(resposta.body);
      List lista = json['recipes'];
      List<Receita> receitas = [];
      for (int i = 0; i < lista.length; i++) {
        Receita receita = Receita.fromJson(lista[i]);
        if (receita.ehRapida) {
          receitas.add(receita);
        }
      }
      return receitas;
    } catch (e) {
      throw ErroApi('Os dados recebidos vieram em um formato inesperado. Tente novamente.');
    }
  }
}
