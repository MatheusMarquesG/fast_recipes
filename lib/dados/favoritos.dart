import 'package:fast_recipes/modelos/receita.dart';

class Favoritos {
  static List<Receita> lista = [];

  static bool contem(int id) {
    for (int i = 0; i < lista.length; i++) {
      if (lista[i].id == id) {
        return true;
      }
    }
    return false;
  }

  static void adicionar(Receita receita) {
    if (contem(receita.id) == false) {
      lista.add(receita);
    }
  }

  static void remover(int id) {
    List<Receita> novaLista = [];
    for (int i = 0; i < lista.length; i++) {
      if (lista[i].id != id) {
        novaLista.add(lista[i]);
      }
    }
    lista = novaLista;
  }
}
