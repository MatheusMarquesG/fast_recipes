import 'package:fast_recipes/dados/favoritos.dart';
import 'package:fast_recipes/modelos/receita.dart';
import 'package:fast_recipes/tema/tema_app.dart';
import 'package:flutter/material.dart';

class TelaDetalhes extends StatefulWidget {
  const TelaDetalhes({super.key, required this.receita});

  final Receita receita;

  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {
  void _alternarFavorito() {
    String mensagem;
    if (Favoritos.contem(widget.receita.id)) {
      Favoritos.remover(widget.receita.id);
      mensagem = 'Receita removida dos favoritos.';
    } else {
      Favoritos.adicionar(widget.receita);
      mensagem = 'Receita adicionada aos favoritos.';
    }
    setState(() {});
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  Widget _imagemReserva() {
    return Container(
      height: 220,
      width: double.infinity,
      color: AppColors.blueSoft,
      child: const Icon(Icons.restaurant_menu, color: AppColors.blue, size: 64),
    );
  }

  Widget _info(IconData icone, String titulo, String valor) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icone, color: AppColors.blue, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tituloSecao(String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 12),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Receita receita = widget.receita;
    bool favorito = Favoritos.contem(receita.id);

    String preparo = 'Não informado';
    if (receita.preparoMinutos != null) {
      preparo = '${receita.preparoMinutos} min';
    }
    String cozimento = 'Não informado';
    if (receita.cozimentoMinutos != null) {
      cozimento = '${receita.cozimentoMinutos} min';
    }
    String total = 'Não informado';
    if (receita.tempoTotal != null) {
      total = '${receita.tempoTotal} min';
    }

    List<Widget> infos = [];
    infos.add(_info(Icons.timer_outlined, 'Preparo', preparo));
    infos.add(_info(Icons.local_fire_department_outlined, 'Cozimento', cozimento));
    infos.add(_info(Icons.schedule, 'Total', total));
    if (receita.porcoes != null && receita.porcoes! > 0) {
      infos.add(_info(Icons.people_outline, 'Porções', '${receita.porcoes}'));
    }
    infos.add(_info(Icons.star_outline, 'Avaliação', receita.textoAvaliacao));
    if (receita.dificuldade != null) {
      infos.add(_info(Icons.signal_cellular_alt, 'Dificuldade', receita.dificuldade!));
    }

    List<Widget> ingredientes = [];
    for (int i = 0; i < receita.ingredientes.length; i++) {
      ingredientes.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(Icons.circle, size: 8, color: AppColors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  receita.ingredientes[i],
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    List<Widget> passos = [];
    for (int i = 0; i < receita.instrucoes.length; i++) {
      passos.add(
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.blueSoft,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  receita.instrucoes[i],
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Detalhes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _alternarFavorito,
            tooltip: favorito ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
            icon: Icon(
              favorito ? Icons.favorite : Icons.favorite_border,
              color: favorito ? AppColors.blue : AppColors.textPrimary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: receita.imagem == null
                  ? _imagemReserva()
                  : Image.network(
                      receita.imagem!,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, erro, stack) {
                        return _imagemReserva();
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Text(
              receita.nomeExibicao,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            if (receita.tiposRefeicao.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: receita.tiposRefeicao.map((tipo) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.blueSoft,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tipo,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blue,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 20),
            Wrap(spacing: 10, runSpacing: 10, children: infos),
            _tituloSecao('Ingredientes'),
            if (ingredientes.isEmpty)
              const Text(
                'Ingredientes não informados para esta receita.',
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
              )
            else
              ...ingredientes,
            _tituloSecao('Modo de preparo'),
            if (passos.isEmpty)
              const Text(
                'Instruções não informadas para esta receita.',
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
              )
            else
              ...passos,
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _alternarFavorito,
              icon: Icon(favorito ? Icons.favorite : Icons.favorite_border),
              label: Text(
                favorito ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
