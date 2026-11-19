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
