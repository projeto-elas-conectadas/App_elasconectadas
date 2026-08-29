// Teste básico da rota inicial configurada no aplicativo.
import 'package:flutter_test/flutter_test.dart';
import 'package:elasconectadas_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('abre a tela de login na rota inicial',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ElasConectadasApp());
    await tester.pumpAndSettle();

    expect(find.text('Entrar'), findsWidgets);
    expect(find.text('Cadastre-se'), findsOneWidget);
  });
}
