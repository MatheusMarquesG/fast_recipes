import 'package:fast_recipes/componentes/cartao_receita.dart';
import 'package:fast_recipes/componentes/estados.dart';
import 'package:fast_recipes/modelos/receita.dart';
import 'package:fast_recipes/servicos/servico_receitas.dart';
import 'package:fast_recipes/telas/tela_detalhes.dart';
import 'package:fast_recipes/tema/tema_app.dart';
import 'package:flutter/material.dart';

class TelaListagem extends StatefulWidget {
  const TelaListagem({super.key});

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  List<Receita> _receitas = [];
  bool _carregando = false;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    if (_carregando) {
      return;
    }
    setState(() {
      _carregando = true;
      _erro = null;
    });
    try {
      List<Receita> resultado = await ServicoReceitas.buscarTodas();
      if (!mounted) return;
      setState(() {
        _receitas = resultado;
        _carregando = false;
      });
    } on ErroApi catch (e) {
      if (!mounted) return;
      setState(() {
        _erro = e.mensagem;
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

  Widget _conteudo() {
    if (_carregando) {
      return const EstadoCarregando(mensagem: 'Carregando receitas...');
    }
    if (_erro != null) {
      return EstadoMensagem(
        icone: Icons.wifi_off,
        titulo: 'Algo deu errado',
        texto: _erro!,
        textoBotao: 'Tentar novamente',
        aoPressionar: _carregar,
      );
    }
    if (_receitas.isEmpty) {
      return const EstadoMensagem(
        icone: Icons.no_food_outlined,
        titulo: 'Nenhuma receita disponível',
        texto: 'Não há receitas para mostrar no momento.',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      itemCount: _receitas.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              '${_receitas.length} receitas de até 30 min',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          );
        }
        Receita receita = _receitas[index - 1];
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
          'Todas as receitas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: _conteudo(),
    );
  }
}
