import 'package:fast_recipes/componentes/cartao_receita.dart';
import 'package:fast_recipes/componentes/estados.dart';
import 'package:fast_recipes/dados/favoritos.dart';
import 'package:fast_recipes/modelos/receita.dart';
import 'package:fast_recipes/telas/tela_detalhes.dart';
import 'package:fast_recipes/tema/tema_app.dart';
import 'package:flutter/material.dart';

class TelaFavoritos extends StatefulWidget {
  const TelaFavoritos({super.key, required this.aoExplorar});

  final VoidCallback aoExplorar;

  @override
  State<TelaFavoritos> createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<TelaFavoritos> {
  Future<void> _abrirDetalhes(Receita receita) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaDetalhes(receita: receita)),
    );
    setState(() {});
  }

  void _remover(Receita receita) {
    Favoritos.remover(receita.id);
    setState(() {});
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${receita.nomeExibicao} removida dos favoritos.'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            Favoritos.adicionar(receita);
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Receita> lista = Favoritos.lista;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Favoritos',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lista.isEmpty
                      ? 'Suas receitas salvas aparecem aqui.'
                      : '${lista.length} receita(s) salva(s) nesta sessão.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: lista.isEmpty
                ? EstadoMensagem(
                    icone: Icons.favorite_border,
                    titulo: 'Nenhum favorito ainda',
                    texto: 'Abra uma receita e toque no coração para salvá-la aqui.',
                    textoBotao: 'Explorar receitas',
                    aoPressionar: widget.aoExplorar,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      Receita receita = lista[index];
                      return CartaoReceita(
                        receita: receita,
                        aoTocar: () => _abrirDetalhes(receita),
                        aoRemover: () => _remover(receita),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
