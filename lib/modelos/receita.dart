class Receita {
  final int id;
  final String nome;
  final String? imagem;
  final List<String> ingredientes;
  final List<String> instrucoes;
  final int? preparoMinutos;
  final int? cozimentoMinutos;
  final int? porcoes;
  final num? avaliacao;
  final String? dificuldade;
  final List<String> tiposRefeicao;

  Receita({
    required this.id,
    required this.nome,
    this.imagem,
    required this.ingredientes,
    required this.instrucoes,
    this.preparoMinutos,
    this.cozimentoMinutos,
    this.porcoes,
    this.avaliacao,
    this.dificuldade,
    required this.tiposRefeicao,
  });

  factory Receita.fromJson(Map<String, dynamic> json) {
    return Receita(
      id: json['id'],
      nome: json['name'] ?? '',
      imagem: json['image'],
      ingredientes: List<String>.from(json['ingredients'] ?? []),
      instrucoes: List<String>.from(json['instructions'] ?? []),
      preparoMinutos: json['prepTimeMinutes'] is int ? json['prepTimeMinutes'] : null,
      cozimentoMinutos: json['cookTimeMinutes'] is int ? json['cookTimeMinutes'] : null,
      porcoes: json['servings'] is int ? json['servings'] : null,
      avaliacao: json['rating'] is num ? json['rating'] : null,
      dificuldade: json['difficulty'],
      tiposRefeicao: List<String>.from(json['mealType'] ?? []),
    );
  }

  String get nomeExibicao {
    if (nome.trim().isEmpty) {
      return 'Receita sem nome';
    }
    return nome;
  }

  int? get tempoTotal {
    if (preparoMinutos == null || cozimentoMinutos == null) {
      return null;
    }
    return preparoMinutos! + cozimentoMinutos!;
  }

  // O app só mostra receitas que ficam prontas em até 30 minutos.
  bool get ehRapida {
    return tempoTotal != null && tempoTotal! <= 30;
  }

  String get textoTempo {
    if (tempoTotal == null) {
      return 'Tempo não informado';
    }
    return '$tempoTotal min';
  }

  String get textoAvaliacao {
    if (avaliacao == null) {
      return 'Sem avaliação';
    }
    return '${avaliacao!.toStringAsFixed(1).replaceAll('.', ',')} / 5';
  }
}
