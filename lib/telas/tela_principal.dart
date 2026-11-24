import 'package:fast_recipes/componentes/cartao_receita.dart';
import 'package:fast_recipes/componentes/estados.dart';
import 'package:fast_recipes/modelos/receita.dart';
import 'package:fast_recipes/servicos/servico_receitas.dart';
import 'package:fast_recipes/telas/tela_detalhes.dart';
import 'package:fast_recipes/telas/tela_favoritos.dart';
import 'package:fast_recipes/telas/tela_listagem.dart';
import 'package:fast_recipes/tema/tema_app.dart';
import 'package:flutter/material.dart';
import 'package:fast_recipes/componentes/cartao_pesquisa.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indice = 0;
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

  void _abrirListagem() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaListagem()),
    );
  }

  void _abrirDetalhes(Receita receita) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaDetalhes(receita: receita)),
    );
  }

  Widget _explorar() {
    List<Widget> destaques = [];
    if (_carregando) {
      destaques.add(const EstadoCarregando(mensagem: 'Carregando receitas...'));
    } else if (_erro != null) {
      destaques.add(
        EstadoMensagem(
          icone: Icons.wifi_off,
          titulo: 'Algo deu errado',
          texto: _erro!,
          textoBotao: 'Tentar novamente',
          aoPressionar: _carregar,
        ),
      );
    }
    for (int i = 0; i < _receitas.length && i < 3; i++) {
      Receita receita = _receitas[i];
      destaques.add(
        CartaoReceita(
          receita: receita,
          aoTocar: () => _abrirDetalhes(receita),
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(),
            const SizedBox(height: 24),
            const SearchCard(),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _abrirListagem,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.blue,
                minimumSize: const Size.fromHeight(48),
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              icon: const Icon(Icons.menu_book_outlined),
              label: const Text('Ver todas as receitas'),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Destaques',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _abrirListagem,
                  child: const Text('Ver todas'),
                ),
              ],
            ),
            const Text(
              'Selecione uma receita para ver o preparo.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            ...destaques,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget corpo;
    if (_indice == 0) {
      corpo = _explorar();
    } else {
      corpo = TelaFavoritos(
        aoExplorar: () {
          setState(() {
            _indice = 0;
          });
        },
      );
    }

    return Scaffold(
      body: corpo,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (valor) {
          setState(() {
            _indice = valor;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore, color: AppColors.blue),
            label: 'Explorar',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite, color: AppColors.blue),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.bolt, color: Colors.white, size: 30),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fast Recipes',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Receitas prontas em até 30 minutos.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
