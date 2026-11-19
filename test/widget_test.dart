import 'package:flutter_test/flutter_test.dart';

import 'package:fast_recipes/app.dart';

void main() {
  testWidgets('Tela principal abre', (WidgetTester tester) async {
    await tester.pumpWidget(const FastRecipesApp());

    expect(find.text('Fast Recipes'), findsOneWidget);
    expect(find.text('Buscar receitas'), findsOneWidget);
  });
}
