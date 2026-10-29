import 'package:flutter/material.dart';

/// Paleta do app: fundo preto, cinzas escuros e azul de destaque.
class AppColors {
  // Azul de destaque (ícones, logo, item ativo da barra).
  static const blue = Color(0xFF4C8DFF);
  // Azul mais forte, usado no fundo do botão para o texto branco ter contraste.
  static const blueStrong = Color(0xFF2563EB);
  // Fundo azul bem escuro (miniatura da receita, indicador da barra).
  static const blueSoft = Color(0xFF14243F);
  static const background = Color(0xFF000000);
  static const surface = Color(0xFF16181C);
  static const border = Color(0xFF2A2E35);
  static const textPrimary = Color(0xFFF2F4F7);
  static const textSecondary = Color(0xFF9AA4B2);
  static const star = Color(0xFFF2A900);
}

class AppTheme {
  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.blue,
      surface: AppColors.surface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIconColor: AppColors.textSecondary,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.blue, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.blueStrong,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.blueSoft,
        iconTheme: WidgetStateProperty.all(
          const IconThemeData(color: AppColors.textSecondary),
        ),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}