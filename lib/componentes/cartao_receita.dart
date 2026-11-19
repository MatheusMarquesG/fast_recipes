import 'package:fast_recipes/modelos/receita.dart';
import 'package:fast_recipes/tema/tema_app.dart';
import 'package:flutter/material.dart';

class CartaoReceita extends StatelessWidget {
  const CartaoReceita({
    super.key,
    required this.receita,
    required this.aoTocar,
    this.aoRemover,
  });

  final Receita receita;
  final VoidCallback aoTocar;
  final VoidCallback? aoRemover;

  Widget _imagemReserva() {
    return Container(
      width: 88,
      height: 88,
      color: AppColors.blueSoft,
      child: const Icon(
        Icons.restaurant_menu,
        color: AppColors.blue,
        size: 32,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String info = receita.textoTempo;
    if (receita.dificuldade != null) {
      info = '$info • ${receita.dificuldade}';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: aoTocar,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: receita.imagem == null
                      ? _imagemReserva()
                      : Image.network(
                          receita.imagem!,
                          width: 88,
                          height: 88,
                          fit: BoxFit.cover,
                          errorBuilder: (context, erro, stack) {
                            return _imagemReserva();
                          },
                        ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receita.nomeExibicao,
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
                          const Icon(Icons.star,
                              size: 18, color: AppColors.star),
                          const SizedBox(width: 4),
                          Text(
                            receita.textoAvaliacao,
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
                if (aoRemover != null)
                  IconButton(
                    onPressed: aoRemover,
                    tooltip: 'Remover dos favoritos',
                    icon: const Icon(Icons.delete_outline,
                        color: AppColors.textSecondary),
                  )
                else
                  const Icon(Icons.chevron_right,
                      color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
