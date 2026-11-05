import 'package:fast_recipes/tema/tema_app.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatefulWidget {
  const SearchCard({super.key});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  final TextEditingController _controller = TextEditingController();
  String? _erro;
  String? _termo;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _pesquisar() {
    String texto = _controller.text;

    if (texto.isEmpty) {
      setState(() {
        _erro = 'Digite o nome de uma receita para pesquisar. Ex.: bolo de cenoura';
        _termo = null;
      });
      return;
    }

    if (texto.trim().isEmpty) {
      setState(() {
        _erro = 'O campo tem apenas espaços. Digite pelo menos uma letra do nome da receita.';
        _termo = null;
      });
      return;
    }

    texto = texto.trim();
    while (texto.contains('  ')) {
      texto = texto.replaceAll('  ', ' ');
    }

    setState(() {
      _erro = null;
      _termo = texto;
    });
  }

  void _novaPesquisa() {
    _controller.clear();
    setState(() {
      _erro = null;
      _termo = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pesquise uma receita pelo nome.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _pesquisar(),
            decoration: InputDecoration(
              labelText: 'Nome da receita',
              hintText: 'Ex.: bolo de cenoura',
              prefixIcon: const Icon(Icons.search),
              errorText: _erro,
              errorMaxLines: 2,
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: _pesquisar,
            child: const Text('Buscar receitas'),
          ),
          if (_termo != null) ...[
            const SizedBox(height: 16),
            Text(
              'Pesquisando por: "$_termo"',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Resultados provisórios.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            TextButton(
              onPressed: _novaPesquisa,
              child: const Text('Nova pesquisa'),
            ),
          ],
        ],
      ),
    );
  }
}