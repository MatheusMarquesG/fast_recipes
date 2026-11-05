import 'package:fast_recipes/tema/tema_app.dart';
import 'package:flutter/material.dart';
import 'package:fast_recipes/componentes/cartao_pesquisa.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Header(),
              SizedBox(height: 24),
              SearchCard(),
              SizedBox(height: 32),
              Text(
                'Receitas disponíveis',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Selecione uma receita para ver o preparo.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              SizedBox(height: 16),
              // Dados fictícios, serão substituídos pela API.
              _RecipeCard(
                name: 'Salada de grão-de-bico',
                info: '25 min • Fácil',
                rating: '4,6 / 5',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (_) {},
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

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.name,
    required this.info,
    required this.rating,
  });

  final String name;
  final String info;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Alternativa visual para quando a imagem não existir ou falhar (RF02).
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.blueSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.restaurant_menu,
              color: AppColors.blue,
              size: 32,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  info,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, size: 18, color: AppColors.star),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}