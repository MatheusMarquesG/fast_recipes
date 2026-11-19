import 'package:fast_recipes/componentes/cartao_receita.dart';
import 'package:fast_recipes/componentes/estados.dart';
import 'package:fast_recipes/dados/receitas_exemplo.dart';
import 'package:fast_recipes/modelos/receita.dart';
import 'package:fast_recipes/telas/tela_detalhes.dart';
import 'package:fast_recipes/tema/tema_app.dart';
import 'package:flutter/material.dart';

class TelaPesquisa extends StatefulWidget {
  const TelaPesquisa({super.key, required this.termo});

  final String termo;

  @override
  State<TelaPesquisa> createState() => _TelaPesquisaState();
}

class _TelaPesquisaState extends State<TelaPesquisa> {
  List<Receita> _resultados = [];
  bool _carregando = false;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _buscar();
  }

  Future<void> _buscar() async {
    if (_carregando) {
      return;
    }
    setState(() {
      _carregando = true;
      _erro = null;
    });
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      List<Receita> encontrados = [];
      String termo = widget.termo.toLowerCase();
      for (int i = 0; i < receitasExemplo.length; i++) {
        if (receitasExemplo[i].nome.toLowerCase().contains(termo)) {
          encontrados.add(receitasExemplo[i]);
        }
      }
      if (!mounted) return;
      setState(() {
        _resultados = encontrados;
        _carregando = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _erro = 'Não foi possível concluir a pesquisa. Verifique sua conexão e tente novamente.';
        _carregando = false;
      });
    }
  }

  void _abrirDetalhes(Receita receita) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaDetalhes(receita: receita)),
    );
  }

  void _limparPesquisa() {
    Navigator.pop(context, true);
  }

  Widget _conteudo() {
    if (_carregando) {
      return const EstadoCarregando(mensagem: 'Pesquisando receitas...');
    }
    if (_erro != null) {
      return EstadoMensagem(
        icone: Icons.wifi_off,
        titulo: 'Falha na pesquisa',
        texto: _erro!,
        textoBotao: 'Tentar novamente',
        aoPressionar: _buscar,
      );
    }
    if (_resultados.isEmpty) {
      return EstadoMensagem(
        icone: Icons.search_off,
        titulo: 'Nenhuma receita encontrada',
        texto: 'Não encontramos receitas com o nome "${widget.termo}". Tente outro nome.',
        textoBotao: 'Nova pesquisa',
        aoPressionar: _limparPesquisa,
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: _resultados.length,
      itemBuilder: (context, index) {
        Receita receita = _resultados[index];
        return CartaoReceita(
          receita: receita,
          aoTocar: () => _abrirDetalhes(receita),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Resultados',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.textSecondary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '"${widget.termo}"',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _limparPesquisa,
                    icon: const Icon(Icons.close, size: 18),
                    label: const Text('Limpar'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: _conteudo()),
        ],
      ),
    );
  }
}
