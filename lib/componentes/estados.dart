import 'package:fast_recipes/tema/tema_app.dart';
import 'package:flutter/material.dart';

class EstadoCarregando extends StatelessWidget {
  const EstadoCarregando({super.key, required this.mensagem});

  final String mensagem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.blue),
            const SizedBox(height: 16),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EstadoMensagem extends StatelessWidget {
  const EstadoMensagem({
    super.key,
    required this.icone,
    required this.titulo,
    required this.texto,
    this.textoBotao,
    this.aoPressionar,
  });

  final IconData icone;
  final String titulo;
  final String texto;
  final String? textoBotao;
  final VoidCallback? aoPressionar;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.blueSoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icone, color: AppColors.blue, size: 36),
            ),
            const SizedBox(height: 18),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              texto,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            if (textoBotao != null && aoPressionar != null) ...[
              const SizedBox(height: 20),
              FilledButton(
                onPressed: aoPressionar,
                child: Text(textoBotao!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
