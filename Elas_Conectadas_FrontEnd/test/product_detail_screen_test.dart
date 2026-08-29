import 'package:elasconectadas_app/core/models/produto_model.dart';
import 'package:elasconectadas_app/features/ads/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('mostra os dados do anúncio recebido pela navegação',
      (tester) async {
    const product = ProdutoModel(
      id: 'cfe231d2-74a6-44dd-a3dc-fd50c6f73e31',
      nome: 'Consultoria financeira',
      descricao: 'Organização financeira para pequenos negócios.',
      preco: 'A partir de R\$ 120',
      categoria: 'SERVICE',
      imagemPrincipal: '',
      userId: '42ddab2c-6d0b-4cf6-8075-8dc038c5096e',
      regiaoAtendimento: 'Atendimento on-line',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: ProductDetailScreen(
          productId: 'cfe231d2-74a6-44dd-a3dc-fd50c6f73e31',
          initialProduct: product,
        ),
      ),
    );

    expect(find.text('Consultoria financeira'), findsOneWidget);
    expect(find.text('SERVIÇO'), findsOneWidget);
    expect(find.text('Atendimento on-line'), findsOneWidget);
    expect(find.text('Organização financeira para pequenos negócios.'),
        findsOneWidget);
  });
}
