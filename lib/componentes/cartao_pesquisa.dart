import 'package:fast_recipes/telas/tela_pesquisa.dart';
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
  bool _abrindo = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pesquisar() async {
    if (_abrindo) {
      return;
    }

    String texto = _controller.text;

    if (texto.isEmpty) {
      setState(() {
        _erro = 'Digite o nome de uma receita para pesquisar. Ex.: bolo de cenoura';
      });
      return;
    }

    if (texto.trim().isEmpty) {
      setState(() {
        _erro = 'O campo tem apenas espaços. Digite pelo menos uma letra do nome da receita.';
      });
      return;
    }

    texto = texto.trim();
    while (texto.contains('  ')) {
      texto = texto.replaceAll('  ', ' ');
    }

    setState(() {
      _erro = null;
      _abrindo = true;
    });

    FocusScope.of(context).unfocus();

    final limpar = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaPesquisa(termo: texto)),
    );

    if (!mounted) return;
    setState(() {
      _abrindo = false;
    });
    if (limpar == true) {
      _novaPesquisa();
    }
  }

  void _novaPesquisa() {
    _controller.clear();
    setState(() {
      _erro = null;
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
            onChanged: (_) {
              setState(() {});
            },
            decoration: InputDecoration(
              labelText: 'Nome da receita',
              hintText: 'Ex.: bolo de cenoura',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _controller.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: _novaPesquisa,
                      tooltip: 'Limpar',
                      icon: const Icon(Icons.close),
                    ),
              errorText: _erro,
              errorMaxLines: 2,
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: _abrindo ? null : _pesquisar,
            child: const Text('Buscar receitas'),
          ),
        ],
      ),
    );
  }
}