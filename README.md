# Fast Recipes

Aplicativo Flutter de receitas rápidas: mostra apenas receitas que ficam prontas em até 30 minutos (preparo + cozimento). Os dados vêm da API pública [DummyJSON Recipes](https://dummyjson.com/docs/recipes).

## Funcionalidades

- **Tela principal:** nome do app, campo de pesquisa e botão para a listagem. Ao abrir, já carrega as receitas.
- **Listagem:** receitas da API com nome e imagem (com um ícone no lugar se a imagem faltar ou falhar), em uma lista rolável.
- **Pesquisa:** busca pelo nome usando o endpoint `/recipes/search`. Remove os espaços externos, não aceita campo vazio e tem o botão "Limpar" para voltar.
- **Detalhes:** ingredientes, modo de preparo, tempos, porções, avaliação e tipos de refeição, com rolagem.
- **Favoritos:** adicionar e remover durante a sessão, sem duplicatas (pelo `id`), em uma aba própria.
- **Carregamento:** indicador de progresso. O botão de busca fica bloqueado enquanto uma pesquisa está sendo aberta.
- **Erros:** mensagens para falha de rede, status de erro e dados inválidos, com o botão "Tentar novamente".
- **Sem resultados:** mensagens diferentes para busca sem resultado, falha de rede e favoritos vazios.
- **Navegação:** abrir os detalhes e voltar retorna à lista ou à pesquisa em que o usuário estava.

### Observações
- **Detalhes:** a tela de detalhes reaproveita o objeto completo que já vem na listagem ou na pesquisa, em vez de chamar `/recipes/{id}`.
- **Consultas concorrentes:** cada tela busca os dados uma vez no `initState`, e a variável `_carregando` impede que uma nova busca comece antes de a anterior terminar.
- **Favoritos:** a classe `Favoritos` (lista estática) é a única fonte de verdade entre as telas.
- **Tempo:** se o tempo de preparo ou de cozimento não for informado, o total aparece como "Tempo não informado", e não como zero. Essas receitas não entram no app.

## Dependências

- `http` ^1.6.0
- `cupertino_icons` ^1.0.8

## SDK

- Flutter 3.47.8
- Dart 3.13.7

## Como executar

```bash
flutter pub get
flutter run
```
